#!/bin/bash
echo "running: $mysqlhost"
md5passwd=$(echo -n $iliasmasterpassword | md5sum | cut -f1 -d' ')

sed -i "s|inserthttppath|$httppath/ilias/|g" /var/www/html/ilias/ilias.ini.php
sed -i "s|inserttimezone|$timezone|g" /var/www/html/ilias/ilias.ini.php
sed -i "s|insertdefaultclientid|$clientid|g" /var/www/html/ilias/ilias.ini.php
sed -i "s|insertmd5adminpassword|$md5passwd|g" /var/www/html/ilias/ilias.ini.php

sed -i "s|insertiliasclientid|$clientid|g" /var/www/html/ilias/data/myilias/client.ini.php
sed -i "s|insertmysqlhost|$mysqlhost|g" /var/www/html/ilias/data/myilias/client.ini.php
sed -i "s|insertmysqluser|$mysqluser|g" /var/www/html/ilias/data/myilias/client.ini.php
sed -i "s|insertmysqlpassword|$mysqlpassword|g" /var/www/html/ilias/data/myilias/client.ini.php
sed -i "s|insertmysqldbname|$mysqldbname|g" /var/www/html/ilias/data/myilias/client.ini.php
sed -i "s|insertmysqlport|$mysqlport|g" /var/www/html/ilias/data/myilias/client.ini.php
sed -i "s|insertlanguage|$language|g" /var/www/html/ilias/data/myilias/client.ini.php


if [ "$initmysql" = "yes" ]; then


	sed -i "s|iliasdbXX99|$mysqldbname|g" /data/resources/configured/iliascleandb.sql
	sed -i "s|myilias|$clientid|g" /data/resources/configured/iliascleandb.sql
	sed -i "s|FirstNameXX99|$initadminfirstname|g" /data/resources/configured/iliascleandb.sql
	sed -i "s|LastNameXX99|$initadminlastname|g" /data/resources/configured/iliascleandb.sql
	sed -i "s|emailmailXX99@x.de|$initadminemail|g" /data/resources/configured/iliascleandb.sql
	sed -i "s|feedbackmailXX99@x.de|$initfeedbackemail|g" /data/resources/configured/iliascleandb.sql

	mysql -u $mysqluser --password="$mysqlpassword" --host=$mysqlhost --port=$mysqlport < /data/resources/configured/iliascleandb.sql

fi

/data/resources/base/entrypoint.sh