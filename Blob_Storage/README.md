# Blob Storage

**Blob storage in Azure** is a service that allows you to *store large amounts of unstructured data* such as text, images, audio, video or any other kind of binary data. 



### Blob storage has three types of resources: 

![AltText](Images/blob_diagram.png)

1. **Storage accounts** = a unique namespace that contains your data. 
2. **Containers** = a logical grouping of blobs within a storage account (*equivalent of Buckets in AWS S3*).
3. **Blobs** = an individual object that can be accessed by a URL.

<br>

## Access Tiers (depending on how often you access the file):
1. **Hot Tier** (Access: *Frequent*)
* cheaper to access
* really quick to load

2. **Cold Tier** (Access: *Medium*)
* costs more to access
* takes longer to load

3. **Archival Tier** (Access: *months/years in between accessing*)
* cheapest tier
* takes a really long time to load (hours)

<br>


## Types of Redundancy ( = having backups):

**LRS - Locally Redundant Storage**

![AltText](Images/LRS.png)

- cheapest
- storing in only one data center (Availability Zone) 
- puts 3 copies in 1 data center

**ZRS - Zone redundant storage**

![AltText](Images/ZRS.png)

- more expensive
- 3 copies of blob, one in each data center (Availability Zone) 

<br>

### Other important points:
* You can access this through either Azure Powershell (similar to WCP - Windows Command Prompt) or Azure CLI (which is a little bit more like Linux). Both can run commands.
* Every command starts with `az`.
* In our script, we will create storage account, create a container, get a blob, download it and upload it to container we made, then give public access to the blob. Then in our app files, we will change 'views - index' file to add that blob (which is a .jpg) to the home page of our app (this will be linked straight to the blob location).


<br>

## Steps:

1. Connect through SSH to your VM that is running the App (which was started through User Data using PM2).

![AltText](Images/1.png)

![AltText](Images/2.png)

2. Once you're in the VM, go to the root folder and then find your app and run `npm install`:

```shell
# going into root folder
cd /

# going into app folder
cd /ci_cd/app

npm install
```

3. If you try to run the app, it will tell you it's already running on port 3000, and we can't have 2 apps running at the same time:

```shell
node app.js
```

![AltText](Images/8.png)


```shell
pm2 start app.js
```

![AltText](Images/11.png)


4. You can check what processes are running (it will give you a massive list):

```shell
ps aux
```

![AltText](Images/3.png)

5. You can narrow it down by using `grep`:

```shell
ps aux | grep node
```
![AltText](Images/4.png)

6. You can now try to kill it using `sudo kill`, but it will stil show up with a different Process ID:

```shell
sudo kill -9 17169
```
![AltText](Images/9.png)

10. You need to kill `pm2`:

![AltText](Images/12.png)


<br>

### How to install Azure CLI

1. The command to install Azure CLI:

```shell
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

2. To Login: 

```shell
az login
```

![AltText](Images/10.png)

3. On the Link: 

![AltText](Images/5.png)

2. You will have to confirm:

![AltText](Images/6.png)

3. It will give you confirmation you have logged in. 

![AltText](Images/7.png)

![AltText](Images/13.png)





<br>

Sources:
- [Blobs - microsoft.com](https://azure.microsoft.com/en-us/products/storage/blobs/)
- [Introduction to Blobs - microsoft.com](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)
- [Install Azure CLI - microsoft.com](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)