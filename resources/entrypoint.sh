#!/bin/bash
#/data/resources/base/restoreilias.sh

echo "running: $mysqlhost"
echo password:
md5passwd=$(echo -n $iliasmasterpassword | md5sum | cut -f1 -d' ')
WWWPATH=/var/www/html
ILIASINI=$WWWPATH/ilias.ini.php

RESPATH=/data/resources
CLEANSQL=$RESPATH/iliascleandb.sql
ETCAPACHE=/etc/php/7.0/apache2
DATAPATH=/opt/iliasdata
share=/data/share
ug=www-data:www-data
CLIENTID=$clientid
CLIENTPATH=$WWWPATH/data/$CLIENTID
CLIENTDATAPATH=$DATAPATH/$CLIENTID
CLIENTINI=$WWWPATH/data/$CLIENTID/client.ini.php



if [ "$initilias" = "yes" ]; then
	echo "Init ilias"

	for i in $CLIENTPATH/css \
	            $CLIENTPATH/lm_data \
	            $CLIENTPATH/mobs \
	            $CLIENTPATH/usr_images
	do 
		mkdir -p $i
	done

	cp $RESPATH/ilias.ini.php $WWWPATH 
	cp $RESPATH/client.ini.php $CLIENTPATH 

	chmod -R 775 $WWWPATH/data 
	chmod 666 $WWWPATH/ilias.ini.php 
	chmod 666 $CLIENTPATH/client.ini.php 
	chown -R $ug $WWWPATH/data 
	

	#Disable old settings
	for i in max_execution_time \
            error_reporting \
            memory_limit \
            display_errors \
            post_max_size \
            upload_max_filesize \
            session.gc_probability \
            session.gc_divisor \
            session.gc_maxlifetime \
            session.hash_function \
            allow_url_fopen
  do 
  	sed -i 's/$i/;$i/g' $ETCAPACHE/php.ini
  done 

	  #Insert new settings
	#See here http://www.ilias.de/docu/goto_docu_pg_6531_367.html
	cat $RESPATH/phpinisettings >> $ETCAPACHE/php.ini 

	for i in $DATAPATH \
	            $share \
	            $CLIENTDATAPATH/files \
	            $CLIENTDATAPATH/forum \
	            $CLIENTDATAPATH/lm_data \
	            $CLIENTDATAPATH/mail 
	do 
		mkdir -p $i
	done 


  for i in $DATAPATH \
         $share \
         $RESPATH/entrypoint.sh \
         $RESPATH/createiliasdump.sh \
         $RESPATH/restoreilias.sh
  do
  	chown -R $ug $i
  	chmod 775 $i
  done 

fi
sed -i "s|inserthttppath|$httppath/ilias/|g" $ILIASINI
sed -i "s|inserttimezone|$timezone|g" $ILIASINI
sed -i "s|insertdefaultclientid|$clientid|g" $ILIASINI
sed -i "s|insertmd5adminpassword|$md5passwd|g" $ILIASINI

sed -i "s|insertiliasclientid|$clientid|g" $CLIENTINI
sed -i "s|insertdbtype|$dbtype|g" $CLIENTINI
sed -i "s|insertmysqlhost|$mysqlhost|g" $CLIENTINI
sed -i "s|insertmysqluser|$mysqluser|g" $CLIENTINI
sed -i "s|insertmysqlpassword|$mysqlpassword|g" $CLIENTINI
sed -i "s|insertmysqldbname|$mysqldbname|g" $CLIENTINI
sed -i "s|insertmysqlport|$mysqlport|g" $CLIENTINI
sed -i "s|insertlanguage|$language|g" $CLIENTINI



apache2ctl -D $apachestartmode