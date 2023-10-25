#!/bin/bash

# update & upgrade
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

# Getting the correct version of MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -

echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt update

# Installing MongoDB
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

# Changing the default IP allowed to 0.0.0.0
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

# If running from the terminal, will echo this to console to confirm:
echo "Modified MongoDB configuration to allow all connections."

# Starting MongoDB
sudo systemctl start mongod

# Enabling MongoDB
sudo systemctl enable mongod

# Seeing the current status of MongoDB (if working, will say 'active')
sudo systemctl status mongod