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
    if [ $# -ne 4 ]; then
        print_fail "Usage: $0 -u <username> -r <repo-name>"
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
            *)
                print_fail "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    # Check if required options are provided
    if [ -z "$username" ] || [ -z "$repo_name" ]; then
        print_fail "Usage: $0 -u <username> -r <repo-name>"
        exit 1
    fi

    print_success "Input values detected: Username: $username, Repo Name: $repo_name"
}

github-setup() {
     print_init "Package Installation"

    # Check if gh is installed
    if ! check_command_installed gh; then
        print_init "Installing GitHub CLI (gh)"
        sudo apt update && sudo apt install -y gh || print_fail "Failed to install gh"
    fi

    # Check if figlet is installed
    if ! check_command_installed figlet; then
        print_init "Installing figlet"
        sudo apt update && sudo apt install -y figlet || print_fail "Failed to install figlet"
    fi

    print_success "Required packages installed"

    print_init "Github-account-setup"
    print_init "configuring basic setup"
    git config --global user.name $username
    git config --global user.mail $username@gmail.com

    
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
    gh repo create "$repo_name"
    mkdir -p $repo_name
    cd $repo_name
    print_intermediate "Initializing $repo_name repository"
    git init
    sleep 1
    git remote add origin "git@github.com:$username/$repo_name.git"
}

git-commit-push(){
    print_init "Chaning to local repository"
    git add .
    git commit -m "Initial commit"
    git push -u origin main
    print_success "Repos pushed sucessfully"
}

main() {
    detect_input_values "$@"

    github-setup
    github-login-test
    github-repo-create 
    git-commit-push
}

main "$@"
