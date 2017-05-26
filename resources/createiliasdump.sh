#!/bin/bash
# How to read shell params: http://stackoverflow.com/a/14203146

HOST=$mysqlhost
PORT=$mysqlport
DATABASE=$mysqldbname
USER=root
PASSWORD=$mysqlpassword
WWWPATH=/var/www/html
WWWDATA=$WWWPATH"/data"
DATA="/opt/iliasdata"
TARGETZIP="/data/share/ilias.tar.gz"

DUMP="/data/resources/iliasdump"
mkdir -p "$DUMP"
rm -r "$DUMP"
mkdir -p "$DUMP"
cp -r "$WWWDATA" "$DUMP/wwwdata"
cp $WWWPATH"/ilias.ini.php" "$DUMP/ilias.ini.php"
cp -r "$DATA" "$DUMP/data"
mysqldump --host $HOST --user="$USER" --password="$PASSWORD" --port=$PORT --databases $DATABASE --add-drop-database > "$DUMP/ilias.sql"

#zip -r "$TARGETZIP" "$DUMP"
cd $DUMP
cd ..
tar -czf "$TARGETZIP" iliasdump/
rm -r "$DUMP"