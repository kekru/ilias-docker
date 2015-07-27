#!/bin/bash
# How to read shell params: http://stackoverflow.com/a/14203146

HOST=$mysqlhost
PORT=$mysqlport
DATABASE=$mysqldbname
USER=$mysqluser
PASSWORD=$mysqlpassword
WWWDATA="/var/www/html/ilias/data"
DATA="/opt/iliasdata"
SRC="$(pwd)/ilias.tar.gz"

while [[ $# > 1 ]]
do
key="$1"

case $key in
    --host)
    HOST="$2"
    shift # past argument
    ;;
    --port)
    PORT="$2"
    shift # past argument
    ;;
    -d|--database)
    DATABASE="$2"
    shift # past argument
    ;;
    -u|--user)
    USER="$2"
    shift # past argument
    ;;
    -p|--password)
    PASSWORD="$2"
    shift # past argument
    ;;
    --wwwdata)
    WWWDATA="$2"
    shift # past argument
    ;;
    --data)
    DATA="$2"
    shift # past argument
    ;;
    --src)
    SRC="$2"
    shift # past argument
    ;;
#    --default)
#    DEFAULT=YES
#    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

DUMP="/data/resources/iliasrestore/"
mkdir -p "$DUMP"
rm -r "$DUMP"
mkdir -p "$DUMP"

#unzip "$SRC" -d "$DUMP"
tar xzvf "$SRC" -C "$DUMP"
cp -a -r "/data/resources/iliasrestore/iliasdump/wwwdata/." $WWWDATA
cp -a -r "/data/resources/iliasrestore/iliasdump/data/." $DATA
cp -a "/data/resources/iliasrestore/iliasdump/ilias.ini.php" "/var/www/html/ilias/ilias.ini.php"

mysql -u "$USER" --password="$PASSWORD" --host=$HOST --port=$PORT < "/data/resources/iliasrestore/iliasdump/ilias.sql"

rm -r "$DUMP"

chown -R www-data:www-data "$WWWDATA"
chown -R www-data:www-data "$DATA"
chmod -R 775 "$WWWDATA"
chmod -R 775 "$DATA"
chown www-data:www-data /var/www/html/ilias/ilias.ini.php
chmod 666 /var/www/html/ilias/ilias.ini.php