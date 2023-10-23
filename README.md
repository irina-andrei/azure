# Azure

### Azure is divided into *Scopes*:
1. Root Management Group
2. Management Groups
3. Subscriptions
4. Resource Groups
5. Resources

<br>

### Important points:
* In Azure, what we call VPCs in AWS here they are called **Virtual Networks** (*V Nets*).
* Management Groups = a way to manage and access company polices for multiple subscriptions.
* Subscriptions = payment account/methods/scheme.
* All resources need to be inside *a Resource Group*. 
* There are also Resource Groups in AWS, but we didn't need to use them.
* With these layers (**Scopes**), we apply policies/permissions/compliance. You can set *different policies or permissions for each Scope.* 
* **Active Directory** => Microsoft's proprietary directory service; it essentially controlls users' ecosystem and enables administrators to manage permissions and control access to network resources. 
* **SLA (Service Level Agreement)**: guarantees the more they fall short, the more money you can ask back. 



<br>

Steps for creating VNet:

![AltText](a1.png)

![AltText](a2a.png)

![AltText](a3.png)

![AltText](a4.png)

![AltText](a5.png)

![AltText](a6.png)

![AltText](a7.png)

![AltText](a8.png)

![AltText](a9.png)

![AltText](a10.png)

![AltText](a11.png)

![AltText](a12.png)

![AltText](a13.png)

<br>

Steps for Spinning Up an Instance with the App running:

![AltText](a14.png)

![AltText](a15.png)

![AltText](a16.png)

![AltText](a17.png)

![AltText](a18.png)

![AltText](a19.png)

![AltText](a20_in_case_of_bug.png)

![AltText](a21.png)

![AltText](a23.png)

![AltText](a24.png)

![AltText](a25.png)

![AltText](a26.png)

![AltText](a27.png)

![AltText](a27_2.png)

![AltText](a36_user_data.png)

![AltText](a28.png)

![AltText](a30.png)

![AltText](a31.png)

![AltText](a32.png)

![AltText](a33.png)

![AltText](a34.png)

![AltText](a35.png)

```shell

#!/bin/bash

# update & upgrade
sudo apt update -y
sudo apt upgrade -y 

# install nginx
sudo apt install nginx -y

# setup nginx reverse proxy
sudo apt install sed

# $ and / characters must be escaped by putting a backslash before them
sudo sed -i "s/try_files \$uri \$uri\/ =404;/proxy_pass http:\/\/localhost:3000\/;/" /etc/nginx/sites-available/default

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

# install your app
npm install

# kill any remaining processes
pm2 kill

# run the app
pm2 start app.js

# restart the app
pm2 restart app.js
```

<br>

Sources:
- [Active Directory](https://www.lepide.com/blog/what-is-active-directory-and-how-does-it-work/)