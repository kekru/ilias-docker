FROM whiledo/ilias-base:latest
MAINTAINER Kevin Krummenauer <kevin@whiledo.de>

ENV httppath="http://localhost/" \
    timezone="Europe/Berlin" \
    clientid="myilias" \
    iliasmasterpassword="secret" \

    mysqlhost="127.0.0.1" \
    mysqluser="root" \
    mysqlpassword="my-secret-pw" \
    mysqldbname="ilias" \
    mysqlport="3306" \

    language="de" \
    
    initmysql="no" \
    initadminfirstname="Kevin" \
    initadminlastname="Krummenauer" \
    initadminemail="kevin@whiledo.de" \
    initfeedbackemail="kevin@whiledo.de"


WORKDIR /data
ADD resources /data/resources


RUN cp -r /data/resources/varwwwhtmlilias/* /var/www/html/ilias \
&& chown -R www-data:www-data /var/www/html/ilias \
&& chmod -R 775 /var/www/html/ilias/data \
&& chmod 666 /var/www/html/ilias/ilias.ini.php \
&& chmod 666 /var/www/html/ilias/data/myilias/client.ini.php \

&& cp -r /data/resources/optiliasdata/* /opt/iliasdata \
&& chown -R www-data:www-data /opt/iliasdata \
&& chmod -R 751 /opt/iliasdata \

&& chown www-data:www-data /data/resources/entrypoint.sh \
&& chmod 751 /data/resources/entrypoint.sh \ 

&& /etc/init.d/apache2 restart

EXPOSE 80 443

#run apache in foreground mode, otherwise docker would stop running image directly after having started
ENTRYPOINT ["/data/resources/entrypoint.sh"]

#now run with docker run -d -p 80:80 whiledo/ilias