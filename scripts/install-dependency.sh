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
    print_separator
}

# Failures in Red color
function print_fail {
    local message="$1"
    printf "\e[1m\e[31m%s\e[0m\n" "$message"
    print_separator
}

check_figlet_installed() {
    print_separator
    print_header "1 - FIGLET"
    print_separator
    sleep 2
    if command -v figlet &>/dev/null; then
        print_success "Figlet is already installed"
        return 0
    else
        print_fail "Figlet Package is missing"
        return 1
    fi
}

check_nginx_installed() {
    print_separator
    print_header "2 - Nginx"
    print_separator
    sleep 2
    if command -v nginx &>/dev/null; then
        print_success "Nginx is already installed"
        return 0
    else
        print_fail "Nginx Package is missing"
        return 1
    fi
}

install_figlet() {
    if check_figlet_installed; then
        return
    fi

    os_description=$(lsb_release -a 2>/dev/null | grep "Description:" | awk -F'\t' '{print $2}')
    print_init "$os_description OS is detected on your system."
    printf "\nInstalling Figlet\n"
    print_separator

    if grep -q 'Ubuntu' /etc/os-release; then
        sudo apt-get update
        sudo apt-get install -y figlet

        if [ $? -eq 0 ]; then
            print_success "Figlet is now installed"
        else
            print_fail "Failed to install Figlet"
        fi

    elif grep -qEi 'redhat|centos' /etc/os-release; then
        sudo yum -y install figlet
        if [ $? -eq 0 ]; then
            print_success "Figlet is now installed"
        else
            print_fail "Failed to install Figlet"
        fi

    elif grep -q 'Amazon Linux 2' /etc/os-release || grep -q 'Amazon Linux 3' /etc/os-release; then
        sudo amazon-linux-extras install epel -y
        sudo yum -y install figlet
        if [ $? -eq 0 ]; then
            print_success "Figlet is now installed"
        else
            print_fail "Failed to install Figlet"
        fi
    else
        print_fail "Unsupported Linux distribution"
        exit 1
    fi
}

install_nginx() {
    if check_nginx_installed; then
        return
    fi

    os_description=$(lsb_release -a 2>/dev/null | grep "Description:" | awk -F'\t' '{print $2}')
    print_init "$os_description OS is detected on your system."
    print_intermediate "\nInstalling Nginx\n"
    print_separator
    if grep -q 'Ubuntu' /etc/os-release; then
        sudo apt-get update
        sudo apt-get install -y nginx
        if [ $? -eq 0 ]; then
            print_success "Nginx is now installed"
        else
            print_fail "Failed to install Nginx"
        fi
    elif grep -qEi 'redhat|centos' /etc/os-release; then
        sudo yum -y install nginx
        if [ $? -eq 0 ]; then
            print_success "Nginx is now installed"
        else
            print_fail "Failed to install Nginx"
        fi
    else
        print_fail "Unsupported Linux distribution"
        exit 1
    fi
}

main() {
    install_figlet
    install_nginx
}

main
