FROM ubuntu:14.04
MAINTAINER Kevin Krummenauer <kevin@whiledo.de>

#Install packages as described here http://www.ilias.de/docu/ilias.php?ref_id=367&from_page=6531&obj_id=56842&cmd=layout&cmdClass=illmpresentationgui&cmdNode=kd&baseClass=ilLMPresentationGUI
#no mysql-client and no mysql-server, because they should run in a separate Docker container
RUN apt-get update && apt-get install -y \
	wget \
	zip \
	apache2 \
	php5 \
	php5-gd \
	php5-mysql \
	php5-curl \
	php-auth \
	php-auth-http \
	php5-xsl \
	htmldoc \
	imagemagick \
	mysql-client \
	sendmail \
	openjdk-7-jdk

WORKDIR /data
ADD resources /data/resources/base

#Disable old settings
RUN sed -i 's/max_execution_time/;max_execution_time/g' /etc/php5/apache2/php.ini \
&& sed -i 's/memory_limit/;memory_limit/g' /etc/php5/apache2/php.ini \

&& sed -i 's/error_reporting/;error_reporting/g' /etc/php5/apache2/php.ini \
&& sed -i 's/display_errors/;display_errors/g' /etc/php5/apache2/php.ini \

&& sed -i 's/post_max_size/;post_max_size/g' /etc/php5/apache2/php.ini \
&& sed -i 's/upload_max_filesize/;upload_max_filesize/g' /etc/php5/apache2/php.ini \

&& sed -i 's/session.gc_probability/;session.gc_probability/g' /etc/php5/apache2/php.ini \
&& sed -i 's/session.gc_divisor/;session.gc_divisor/g' /etc/php5/apache2/php.ini \
&& sed -i 's/session.gc_maxlifetime/;session.gc_maxlifetime/g' /etc/php5/apache2/php.ini \
&& sed -i 's/session.hash_function/;session.hash_function/g' /etc/php5/apache2/php.ini \

&& sed -i 's/allow_url_fopen/;allow_url_fopen/g' /etc/php5/apache2/php.ini \

#Insert new settings, as described here http://www.ilias.de/docu/ilias.php?ref_id=367&obj_id=6531&obj_type=PageObject&cmd=layout&cmdClass=illmpresentationgui&cmdNode=kd&baseClass=ilLMPresentationGUI
&& cat /data/resources/base/phpinisettings >> /etc/php5/apache2/php.ini

#Then download ilias, unzip it and restart apache2
RUN wget https://github.com/ILIAS-eLearning/ILIAS/archive/v5.0.3.tar.gz -O /data/resources/base/ilias.tar.gz \
&& tar xzvf /data/resources/base/ilias.tar.gz -C /var/www/html/ \
&& mv /var/www/html/ILIAS-5.0.3 /var/www/html/ilias \
&& rm /data/resources/base/ilias.tar.gz

#RUN unzip /data/resources/base/ILIAS-5.0.3.zip -d /var/www/html/ \
#&& mv /var/www/html/ILIAS-5.0.3 /var/www/html/ilias \
#&& rm /data/resources/base/ILIAS-5.0.3.zip

RUN chown -R www-data:www-data /var/www/html/ilias \
&& mkdir /opt/iliasdata \
&& chown www-data:www-data /opt/iliasdata \
&& chmod 751 /opt/iliasdata \

&& chown www-data:www-data /data/resources/base/entrypoint.sh \
&& chmod 751 /data/resources/base/entrypoint.sh \

&& /etc/init.d/apache2 restart

ENV apachestartmode="FOREGROUND"

ENTRYPOINT ["/data/resources/base/entrypoint.sh"]

EXPOSE 80 443

#run apache in foreground mode, otherwise docker would stop running image directly after having started
#CMD ["apache2ctl", "-D", "FOREGROUND"]


#now run with docker run -d -p 80:80 whiledo/ilias
#then start configuration on http://<your-IP>/ilias