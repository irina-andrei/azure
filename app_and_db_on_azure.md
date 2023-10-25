
# Getting the App and Database Running (using User Data)

![AltText](Images/2tier_diagram_azure.png)

## Database VM

User Data: 

```shell
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
```

<br>

### App VM

1. Go to Virtual Machines:

![AltText](Images/a14.png)

2. Click Create:

![AltText](Images/a15.png)

3. Select Azure virtual machine:

![AltText](Images/a16.png)

4. Search for `ubuntu pro 18.04 lts`:

![AltText](Images/a17.png)

5. Select Gen2:

![AltText](Images/a18.png)

6. You will get this error, select 'Standard' for Security Type:

![AltText](Images/a19.png)

7. In case you have a bug when selecting this, go to Marketplace and search for `ubuntu pro 18.04 lts`:

![AltText](Images/a20_in_case_of_bug.png)

8. Select VM size:

![AltText](Images/a21.png)

9. To recap, select Resource group, VM name, region, Availability zone:

![AltText](Images/a23.png)

10. Size:

![AltText](Images/a24.png)

11. Change to `admin user` and choose your security key:

![AltText](Images/a25.png)

12. Choose ports: 

![AltText](Images/a26.png)

13. Choose Standard SSD:

![AltText](Images/a27.png)

14. Delete with VM:

![AltText](Images/a27_2.png)

15. Add User Data:

![AltText](Images/a36_user_data.png)

```shell
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
```

16. Select VNet, subnet, Public IP and choose delete:

![AltText](Images/a28.png)

17. Add Name Tag:

![AltText](Images/a30.png)

18. Check all information is correct, then click Create:

![AltText](Images/a31.png)

![AltText](Images/a32.png)

19. Confirmation of deployment complete:

![AltText](Images/a33.png)

20. Your VM:

![AltText](Images/a34.png)

21. If you want to remove VM, click Delete:

![AltText](Images/a35.png)


<br>