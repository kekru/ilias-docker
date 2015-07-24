#!/bin/bash

service mysql restart
mysqladmin -u root -p password "$containermysql_rootpw" --host=127.0.0.1 --password=""

/data/resources/transientmysql/createiliasdump.sh --target /opt/w.zip
/data/resources/configured/entrypoint.sh
