#!/bin/bash
# How to read shell params: http://stackoverflow.com/a/14203146

HOST=$mysqlhost
PORT=$mysqlport
DATABASE=$mysqldbname
USER=$mysqluser
PASSWORD=$mysqlpassword
WWWDATA="/var/www/html/ilias/data"
DATA="/opt/iliasdata"
TARGETZIP="$(pwd)/ilias.tar.gz"

while [[ $# > 1 ]]
do
key="$1"

case $key in
    ---host)
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
    --target)
    TARGETZIP="$2"
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

DUMP="/data/resources/iliasdump"
mkdir -p "$DUMP"
rm -r "$DUMP"
mkdir -p "$DUMP"
cp -r "$WWWDATA" "$DUMP/wwwdata"
cp "/var/www/html/ilias/ilias.ini.php" "$DUMP/ilias.ini.php"
cp -r "$DATA" "$DUMP/data"
mysqldump --host $HOST --user="$USER" --password="$PASSWORD" --port=$PORT --databases $DATABASE --add-drop-database > "$DUMP/ilias.sql"

#zip -r "$TARGETZIP" "$DUMP"
cd $DUMP
cd ..
tar -czf "$TARGETZIP" iliasdump/
rm -r "$DUMP"