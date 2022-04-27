#!/bin/bash

sudo mkdir /etc/ssl/private
sudo chmod 700 /etc/ssl/private

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=IN/ST=TS/L=HYD/O=Moengage/OU=IT/CN=uadepu"
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
sudo touch /etc/nginx/conf.d/ssl.conf

sudo cat > /etc/nginx/conf.d/ssl.conf << EOF
server {
    listen 80;
    listen [::]:80;
    server_name localhost;
    return 301 $scheme://$server_name$request_uri;
}

server {
    listen 443 http2 ssl;
    listen [::]:443 http2 ssl;

    server_name localhost;

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ssl_dhparam /etc/ssl/certs/dhparam.pem;

    ########################################################################
    # from https://cipherlist.eu/                                            #
    ########################################################################
    
   
    ##################################
    # END https://cipherlist.eu/ BLOCK #
    ##################################

    root /usr/share/nginx/html;

    location / {
    }

    error_page 404 /404.html;
    location = /404.html {
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
    }
}
EOF

sudo nginx -t
sudo systemctl restart nginx
echo $?