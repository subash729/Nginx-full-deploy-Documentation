#!/bin/bash

# Global variables
root_base_dir="/var/www/custom_site"
nginx_config_base_dir="/etc/nginx/sites-custom"


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

copy_website_to_repo() {
    print_init "Copying website source-code"
    cp -r $root_base_dir/* source-code/
}

main() {
    copy_website_to_repo 
    
    unset root_base_dir nginx_config_base_dir
}

main "$@"