FROM whiledo/ilias-transientmysql:latest
MAINTAINER Kevin Krummenauer <kevin@whiledo.de>

ENV initmysql="no"

WORKDIR /data

VOLUME /var/lib/mysql

ENTRYPOINT ["/data/resources/transientmysql/entrypoint.sh"]

