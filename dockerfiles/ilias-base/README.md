  
## Ilias Base ##  

This is the base image for the Ilias server.

Run the following way:  
`docker run -d -p 80:80 whiledo/ilias-base`  

If you want your files being saved to disk, mount the /var/www/html/ilias/ of the image as a Volume.  
Add `--name mydocker -v /var/www/html/ilias/ -v /opt/iliasdata/` when running the image or use the [Ilias Prod Image](https://hub.docker.com/r/whiledo/ilias-prod/).

Restart the container using `docker start mydocker`

## Initialize DB

Add `-e initmysql="yes"` to the docker run command to initialize the MySQL Ilias DB.

## Not supported yet  
NOT supported yet is
+ Dockers containers linking

## Create Dump of Data and Restore
The dump contains MySQL data and Filedata (e.g. User pictures).

### Create dump
There are two possibilities:
+ Add `-e createdump="yes" -v /home/usernameOfDockerHost:/data/share` to docker run. The dump will appear on the host in `/home/usernameOfDockerHost/ilias.tar.gz`
+ Enter a running container with `docker exec -it <conatinerid> /bin/bash` and run `/data/resources/base/createiliasdump.sh --target /data/share/ilias.tar.gz`  
Leave the container with `exit` and run `docker cp <containerid>:/data/share/ilias.tar.gz /home/usernameOfDockerHost` to copy the file to your host.

### Restore from dump
There are two possibilities:
+ Put the dump to `/home/usernameOfDockerHost/ilias.tar.gz` and add `-e restorefromdump="yes" -v /home/usernameOfDockerHost:/data/share` to docker run. 
+ Run `docker cp <containerid>:/home/usernameOfDockerHost/ilias.tar.gz /data/share` to copy the dump file from your host to the container.  
Enter a running container with `docker exec -it <conatinerid> /bin/bash` and run `/data/resources/base/restoreilias.sh --src /data/share/ilias.tar.gz`   

## Project's parts ##
The [Base Image](https://hub.docker.com/r/whiledo/ilias-base/) contains Apache and an unconfigured Ilias server.

The [Configured Ilias](https://hub.docker.com/r/whiledo/ilias-configured) contains the Base Image and
the basic configuration (Ilias Settings and MySQL Connection) which you can edit by changing the environment variables,
listed in the Dockerfile.

The [Transient MySQL Ilias Image](https://hub.docker.com/r/whiledo/ilias-transientmysql/) contains the 
Configured Ilias and a MySQL Database which will work as an in-memory db. By default it will not save your data to disk.  
To save data to disk, mount "/var/lib/mysql" as a volume when you start the container (add `-v /var/lib/mysql` to docker run).

The [Ilias Prod Image](https://hub.docker.com/r/whiledo/ilias-prod/) contains the 
Configured Ilias but no MySQL. You should run the [Official MySQL](https://hub.docker.com/_/mysql/) Image for production use.  

## Admin Login  
When setup is completed, login with the following credentials  
Username: `root`  
Password: `homer`  

## Free HTTPS certificate  
This image contains [Let's Encrypt](https://letsencrypt.org/).  
Install the free certificate as shown here [whiledo/letsencrypt-apache-ubuntu/](https://hub.docker.com/r/whiledo/letsencrypt-apache-ubuntu/)  

## Change Document Root  
By default this image will redirect you to yourwebsite.org/ilias. If you want to get your ILIAS on yourwebsite.org you need to change the document root.  
To change the document root create a new Dockerfile which is based on this ILIAS image.  
Add `sed -i 's|/var/www/html|/var/www/html/ilias|g' /etc/apache2/sites-enabled/000-default.conf` to change the document root.  
This probably causes conflicts with Let's Encrypt.  

## Java  
If you need Java in your ILIAS installation, run `apt-get install -y openjdk-7-jdk` in your running container (enter it with `docker exec -it containername bash`) or Dockerfile 

## Dockerfile based on this image  
Whenever you create a Dockerfile which is based on this image, be sure to add an ENTRYPOINT or default CMD which runs the apache webserver in foreground  
`FROM whiledo/ilias...`  
`...`  
`ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]`  








