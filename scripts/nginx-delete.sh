#!/bin/bash

# Global variables
root_base_dir="/var/www/custom_site"
log_base_dir="/var/log/nginx/custom_site"
nginx_config_base_dir="/etc/nginx/sites-custom"
html_source="$HOME/website/index.html"

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

list_directories() {
    print_separator
    print_header "1-listing-site"
    print_separator

    print_init "Listing Website Directories"
    ls -al $root_base_dir | cut -d " " -f 10

    print_init "Listing Website configuration Directories"
    ls -al $nginx_config_base_dir | cut -d " " -f 10

}

delete_all_directories(){
    print_separator
    print_header "2-Deleting-site"
    print_separator
    print_init "Deleting Directories of Website stored web content"
    sudo rm -rf  $root_base_dir/*
    print_init "Deleting Directories of Website log"
    sudo rm -rf  $log_base_dir/*
    print_init "Deleting Directories of Website Nginx configuration"
    sudo rm -rf  $nginx_config_base_dir/*
}
main() {


    list_directories
    delete_all_directories
    unset server_name port root_base_dir log_base_dir nginx_config_base_dir config_dir site_config_dir config_file config
}

main "$@"
