#!/bin/bash

if [ "$remotemysql" = "yes" ]; then
	sed -i "s|bind-address.*= 127.0.0.1|bind-address = 0.0.0.0|g" /etc/mysql/my.cnf
fi

# touch files, because of docker filesystem problem
# see https://github.com/docker/for-linux/issues/72
find /var/lib/mysql -type f -exec touch {} \;

service mysql start

mysqladmin -u root -p password "$containermysql_rootpw" --host=127.0.0.1 --password=""

#/data/resources/transientmysql/createiliasdump.sh --target /opt/w.zip
/data/resources/configured/entrypoint.sh
