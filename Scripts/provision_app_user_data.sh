#!/bin/bash

# update & upgrade
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

# install nginx
sudo apt install nginx -y

##

# setup nginx reverse proxy
sudo apt install sed

# $ and / characters must be escaped by putting a backslash before them
sudo sed -i "s/try_files \$uri \$uri\/ =404;/proxy_pass http:\/\/localhost:3000\/;/" /etc/nginx/sites-available/default

##

# restart nginx 
sudo systemctl restart nginx

# enable nginx
sudo systemctl enable nginx


##

# installing git
sudo apt install git -y

# cloning the app files to the instance
git clone https://github.com/irina-andrei/ci_cd.git

# tell the os what version of nodejs you want
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

# install nodejs
sudo apt install nodejs -y

# install process manager
sudo npm install pm2 -g

# go to the app folder
cd ci_cd/app

# Exporting DB_HOST
export DB_HOST=mongodb://==PUBLIC_DB_VM_IP_ADDRESS==:27017/posts

# restart nginx
sudo systemctl restart nginx

# install your app
npm install

# kill any remaining processes
pm2 kill

# seed db
node seeds/seed.js

# run the app
pm2 start app.js

# restart the app
pm2 restart app.js
