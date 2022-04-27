#!/bin/bash
echo "Installing nginx"
sudo amazon-linux-extras install nginx1 -y
sudo yum install nginx -y
sudo service enable nginx
sudo service nginx start
nginx -v
echo "Installtion Done"
sudo service nginx stop
sudo rm -rf /usr/share/nginx/html/index.html
sudo echo "<h1>Hello World!</h1>" >> /usr/share/nginx/html/index.html
sudo service nginx start