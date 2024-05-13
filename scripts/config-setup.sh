sudo sed -i '\|include /etc/nginx/conf.d/.*.conf;|a\        include /etc/nginx/sites-custom/subash.com/*;' /etc/nginx/nginx.conf


sudo sed -i '\|include /etc/nginx/conf.d/[^ ]*.conf;|a\        include /etc/nginx/sites-custom/subash.com/*;' /etc/nginx/nginx.conf