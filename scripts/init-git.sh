#!/bin/bash

function print_separator {
    printf "\n%s\n" "--------------------------------------------------------------------------------"
}

function print_header {
    figlet -c -f slant "$1"
    print_separator
}

# Detection in Yellow color
function print_init {
    local message="$1"
    printf "\e[33m%s\e[0m\n" "$message"
}

# Intermediate in Blue color
function print_intermediate {
    local message="$1"
    printf "\e[34m%s\e[0m\n" "$message"
}

# Completion in Green color
function print_success {
    local message="$1"
    printf "\e[1m\e[32m%s\e[0m\n" "$message"
}

# Failures in Red color
function print_fail {
    local message="$1"
    printf "\e[1m\e[31m%s\e[0m\n" "$message"
}

detect_input_values() {
    print_separator
    print_header "INPUT DETECTION"
    print_separator

    # Check if all required arguments are provided
    if [ $# -lt 4 ]; then
        print_fail "Usage: $0 -u <username> -r <repo-name> [-m <email>]"
        exit 1
    fi

    # Parse command-line options
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -u)
                username="$2"
                shift 2
                ;;
            -r)
                repo_name="$2"
                shift 2
                ;;
            -m)
                email="$2"
                shift 2
                ;;
            *)
                print_fail "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    # Check if required options are provided
    if [ -z "$username" ] || [ -z "$repo_name" ]; then
        print_fail "Usage: $0 -u <username> -r <repo-name> [-m <email>]"
        exit 1
    fi

    print_success "Input values detected: Username: $username, Repo Name: $repo_name, Email: ${email:-Not provided}"
}

github-setup() {
    print_init "Package Installation"

    # Check if gh is installed
    if command -v gh &>/dev/null; then
        print_success "gh is already installed"
    elif grep -q 'Ubuntu' /etc/os-release; then
        sudo apt-get update
        sudo apt-get install -y gh
        if [ $? -eq 0 ]; then
            print_success "gh is now installed"
        else
            print_fail "Failed to install gh"
            exit 1
        fi
    else
        print_fail "gh is not installed and OS is not Ubuntu"
        exit 1
    fi

    # Check if figlet is installed
    if command -v figlet &>/dev/null; then
        print_success "figlet is already installed"
    elif grep -q 'Ubuntu' /etc/os-release; then
        sudo apt-get update
        sudo apt-get install -y figlet
        if [ $? -eq 0 ]; then
            print_success "Figlet is now installed"
        else
            print_fail "Failed to install Figlet"
            exit 1
        fi
    else
        print_fail "figlet is not installed and OS is not Ubuntu"
        exit 1
    fi
    
    print_success "Required packages installed"

    print_init "Github-account-setup"
    print_init "configuring basic setup"
    git config --global user.name "$username"
    if [ -n "$email" ]; then
        git config --global user.email "$email"
    else
        print_init "Email not provided. Using default email."
    fi
}

github-login-test() {
    print_separator
    print_header "1-login-check"
    print_separator

    print_init "Testing github-login"
    ssh -T git@github.com
}

github-repo-create() {
    print_init "Creating repository"
    print_init "Manually create the repository on GitHub or authenticate with gh"
    print_init "Initializing $repo_name repository locally"
    mkdir -p "$repo_name"
    cd "$repo_name" || exit
    git init
    git remote add origin "git@github.com:$username/$repo_name.git"
    print_success "Repository $repo_name created locally. Please create it on GitHub or authenticate with gh"
}


git-commit-push() {
    print_init "Changing to local repository"
    echo "Testing" >> README.MD
    git add .
    git commit -m "Initial commit"
    git push -u origin main
    print_success "Repos pushed successfully"
}

main() {
    detect_input_values "$@"

    github-setup
    github-login-test
    github-repo-create
    git-commit-push
}

main "$@"
