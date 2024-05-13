#!/bin/bash

# Global variables
root_base_dir="/var/www/custom_site"
log_base_dir="/var/log/nginx/custom_site"
nginx_config_base_dir="/etc/nginx/sites-custom"
html_source="$HOME/website"

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
        print_fail "Usage: $0 -site <server_name> -port <port>"
        exit 1
    fi

    # Parse command-line options
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -site)
                server_name="$2"
                shift 2
                ;;
            -port)
                port="$2"
                shift 2
                ;;
            *)
                print_fail "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    # Check if required options are provided
    if [ -z "$server_name" ] || [ -z "$port" ]; then
        print_fail "Usage: $0 -site <server_name> -port <port>"
        exit 1
    fi

    print_success "Input values detected: Server Name: $server_name, Port: $port"
}

directory_define() {
    frontend_root_dir=$root_base_dir/$server_name/frontend
    backend_root_dir=$root_base_dir/$server_name/backend

    frontend_log_dir=$log_base_dir/$server_name/frontend
    backend_log_dir=$log_base_dir/$server_name/backend

    nginx_etc_config_dir=$nginx_config_base_dir/$server_name

    html_frontend_destination="$root_base_dir/$server_name/frontend/"
    html_backend_destination="$root_base_dir/$server_name/backend/"

    #Nginx config variable
    nginx_pre_config_dir="$HOME/nginx/$server_name"
    nginx_pre_config_file="$nginx_pre_config_dir/$server_name.frontend.conf"
}

create_directories() {
    print_separator
    print_header "DIRECTORY CREATION"
    print_separator
    # Create root directory for the server - frontend and backend
    if [ ! -d "$frontend_root_dir" ]; then
        print_fail "Frontend Root directory is missing, please wait creating...."
        sudo mkdir -p "$frontend_root_dir"
        sleep 1
        print_success "Created frontend root directory: $frontend_root_dir"
    else
        print_init "Frontend root directory already exists: $frontend_root_dir"
    fi

    if [ ! -d "$backend_root_dir" ]; then
        print_fail "Backend Root directory is missing, please wait creating...."
        sudo mkdir -p "$backend_root_dir"
        sleep 1
        print_success "Created backend root directory: $backend_root_dir"
    else
        print_init "Backend root directory already exists: $backend_root_dir"
    fi

    print_separator
    # Create log directory for the server - frontend and backend
    if [ ! -d "$frontend_log_dir" ]; then
        print_fail "Frontend Log directory is missing, please wait creating...."
        sleep 1
        sudo mkdir -p "$frontend_log_dir"
        print_success "Created frontend log directory: $frontend_log_dir"
    else
        print_init "Frontend log directory already exists: $frontend_log_dir"
    fi

    if [ ! -d "$backend_log_dir" ]; then
        print_fail "Backend Log directory is missing, please wait creating...."
        sudo mkdir -p "$backend_log_dir"
        sleep 1
        print_success "Created backend log directory: $backend_log_dir"
    else
        print_init "Backend log directory already exists: $backend_log_dir"
    fi

    # Create host directory /etc/nginx/sites-custom/$server_name
    if [ ! -d "$nginx_etc_config_dir" ]; then
        print_fail "Nginx config directory is missing, please wait creating...."
        sudo mkdir -p "$nginx_etc_config_dir"
        sleep 1
        print_success "Created Nginx config directory: $nginx_etc_config_dir"
    else
        print_init "Nginx Config directory already exists: $nginx_etc_config_dir"
    fi

    print_separator
    print_intermediate "Allowing Read Privilege to log and root Directory"
    sudo chmod -R +755 $log_base_dir
    sudo chmod -R +755 $root_base_dir
    sudo chmod -R +755 $nginx_config_base_dir
}

generate_nginx_config() {
    print_separator
    print_header "NGINX CONFIGURATION"
    print_separator

    print_init "Generating Nginx configuration, please wait..."
    print_separator
    sleep 1

    # Generate nginx configuration
    config="server {
    listen $port;
    listen [::]:$port;

    server_name $server_name;

    root $frontend_root_dir;

    index index.html index.htm;

    location /about-us {
    index about-us.html index.html;
    }

     location /sign-up {
    index sign-up.html index.html;
    }

    location / {
        try_files \$uri \$uri/ =404;

        proxy_buffering on;
        proxy_buffers 16 4k;
        proxy_buffer_size 2k;

        client_body_buffer_size 1m; # Adjust size as per your requirements
        client_max_body_size 20m;   # Maximum allowed size of the client request body
        client_body_timeout 12s;      # Maximum time between receiving client request body

         # Timeouts
        proxy_connect_timeout       10s; # Maximum time to connect with the proxied server
        send_timeout                10s; # Maximum time to send data to the client
        keepalive_timeout          65s; # Maximum time a connection is allowed to stay open

        add_header X-Frame-Options "SAMEORIGIN";
        add_header X-Content-Type-Options "nosniff";
        add_header Referrer-Policy "strict-origin-when-cross-origin";
        expires 1M; # Cache assets for 1 month
    }

    location ~* \.(css|js|gif|jpe?g|png)$ {
        expires max;
        log_not_found off;
        access_log off;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;

    location = /50x.html {
        root /usr/share/nginx/html;
    }

    access_log $frontend_log_dir/access.log;
    error_log $frontend_log_dir/error.log;
}"


    # Create site config directory and save configuration
    mkdir -p $nginx_pre_config_dir
    echo "$config" > "$nginx_pre_config_file"
    print_success "Nginx configuration generated at: $nginx_pre_config_file"
    sudo chmod -R +755 $nginx_pre_config_dir
}

copy_html_site() {
    print_separator
    print_header "COPY HTML SITE"
    print_separator

    print_init "testing working directory location"
    pwd
    if [ -f "../source-code/sample-website/index.html" ]; then
        print_init "Copying HTML site from $html_source to $html_frontend_destination"
        sudo cp -r "source-code/sample-website"/* "$html_frontend_destination/"
        
        print_success "HTML site copied successfully"
    else
        print_fail "HTML source file not found at github-repo. Trying local fallback directory..."
        if [ -f "$html_source/index.html" ]; then
            print_init "Copying HTML site from fallback directory to $html_frontend_destination"
            sudo cp -r "$html_source"/* "$html_frontend_destination/"
            print_success "HTML site copied successfully from fallback directory"
        else
            print_fail "Fallback HTML source file not found. Cannot copy website."
        fi
    fi
}


copy_restart_nginx_config() {
    print_separator
    print_header "COPY NGINX CONFIG"
    print_separator

    print_init "Copying nginx local configuration to $nginx_config_dir/"
    sudo cp -r $nginx_pre_config_dir/* $nginx_etc_config_dir/
    print_success "Nginx configuration copied to $nginx_etc_config_dir"

    server_config_entry="include /etc/nginx/sites-custom/$server_name/*;"
    # Check if the inclusion entry already exists in nginx.conf
    if ! grep -qF "$server_config_entry" /etc/nginx/nginx.conf; then
        print_init "Initializing $nginx_etc_config_dir Directory to serve config"
        sudo sed -i "\\|include /etc/nginx/conf.d/[^ ]*.conf;|a\\        include /etc/nginx/sites-custom/$server_name/*;" /etc/nginx/nginx.conf

        # Check nginx configuration syntax
    else
        print_init "The inclusion entry already exists in /etc/nginx/nginx.conf. Skipping..."
    fi

# Testing and restarting services
    if sudo nginx -t; then
        print_init "Nginx configuration syntax test successful."
        # Restart nginx if the configuration test is successful
        print_init "Restarting nginx..."
        sudo systemctl restart nginx
        print_success "Nginx restarted successfully."
        # Reload nginx to apply the changes
        print_init "Reloading nginx configuration..."
        sudo nginx -s reload
        print_success "Nginx configuration reloaded successfully."
    else
        print_fail "Nginx configuration test failed. Please check the configuration."
    fi
}

display_details() {
    print_separator
    print_header "IMPORTANT DETAILS"
    print_separator

    local_ip=$(hostname -I | cut -d' ' -f1)


    echo -n "Website Global URL: "
    print_intermediate "http://$server_name:$port"
    echo -n "Website Local URL: "
    print_intermediate "http://$local_ip:$port"
    echo " "

    print_init "Frontend Directories"
    echo -n "Nginx Conf:    "
    print_success "$nginx_etc_config_dir/"
    echo -n "Root Hosting:  "
    print_success "$frontend_root_dir/"
    echo -n "Logs Files:    "
    print_success "$frontend_log_dir."

    echo ""
    print_init "Backend Directories"
    echo -n "Nginx Config:  "
    print_success "$nginx_etc_config_dir/"
    echo -n "Root Hosting:  "
    print_success "$backend_root_dir/"
    echo -n "Logs Files:    "
    print_success "$backend_log_dir/"
}

main() {
    detect_input_values "$@"

    directory_define
    create_directories

    generate_nginx_config
    copy_html_site
    copy_restart_nginx_config
    
    display_details
    unset server_name port root_base_dir log_base_dir nginx_config_base_dir config_dir site_config_dir config_file config
}

main "$@"
