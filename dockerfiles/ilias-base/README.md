This is the base image for the ilias-server.

## Project's parts ##
The <a href="https://hub.docker.com/r/whiledo/ilias-base/">Base Image</a> contains Apache and unconfigured Ilias 

The <a href="https://hub.docker.com/r/whiledo/ilias-configured/">Configured Ilias</a> contains the Base Image and
the basic configuration (Ilias Settings and MySQL Connection) which you can edit by changing the environment variables,
listed in the Dockerfile.

The <a href="https://hub.docker.com/r/whiledo/ilias-transientmysql/">Transient MySQL Ilias Image</a> contains the 
Configured Ilias and a MySQL Database which will work as an in-memory db. By default it will not save your data to disk.
To change that, mount "/var/lib/mysql" as a volume wehen you start the container.
