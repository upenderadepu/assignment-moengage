#!/bin/bash
set -e
echo "Installing nginx"
sudo amazon-linux-extras install nginx1 -y

echo "Installtion Done"
sudo systemctl stop nginx
sudo rm -rf /usr/share/nginx/html/index.html
sudo echo "<h1>Hello World!</h1>" >> /usr/share/nginx/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx

