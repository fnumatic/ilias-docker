#!/bin/bash
# How to read shell params: http://stackoverflow.com/a/14203146

HOST=$mysqlhost
PORT=$mysqlport
DATABASE=$mysqldbname
USER=$mysqluser
PASSWORD=$mysqlpassword
WWWPATH=/var/www/html
WWWDATA=$WWWPATH"/data"
DATA="/opt/iliasdata"
VERSIONFILE=/data/resources/iliasversion
VERSION=$(cat $VERSIONFILE)
DUMP=/opt/backup
DBDUMP=/opt/dbdump
TARGETZIP=$DUMP/ilias-$VERSION.tar.gz
SQLFILE=$DBDUMP/ilias.sql

mkdir -p $DUMP
mkdir -p $DBDUMP

mysqldump --host $HOST --user=$USER --password=$PASSWORD --port=$PORT --databases $DATABASE --add-drop-database > $SQLFILE

tar -czf $TARGETZIP $WWWDATA $DATA $VERSIONFILE $SQLFILE

rm $SQLFILE