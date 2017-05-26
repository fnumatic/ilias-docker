FROM debian:jessie-slim



#Install packages as described here http://www.ilias.de/docu/goto_docu_pg_64272_367.html
#no mysql-client and no mysql-server, because they should run in a separate Docker container
RUN echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.list \ 
  && apt-get update && apt-get install -y curl apt-transport-https \ 
  && apt-get install --yes --force-yes \ 
  && curl http://www.dotdeb.org/dotdeb.gpg | apt-key add - \
  && apt-get install --yes --force-yes --no-install-recommends\
  zip \
  unzip \
  apache2 \ 
  php7.0 \ 
  php7.0-gd \ 
  php7.0-mysql \ 
  php7.0-curl \ 
  php-auth \ 
  php-auth-http \ 
  php7.0-xsl \
  htmldoc \
  imagemagick \
  mysql-client \
  sendmail \
# openjdk-9-jdk \
  && apt-get purge --yes apt-transport-https \
  && apt-get clean \
  && rm -r /var/lib/apt/lists/*


ARG version=5.2.4
ARG ug=www-data:www-data
ARG RESPATH=/data/resources/
ARG wwwpath=/var/www/html

#Download ilias, unzip it
RUN curl -L https://github.com/ILIAS-eLearning/ILIAS/archive/v$version.tar.gz -o $wwwpath/install.tar.gz \ 
&& tar xzf $wwwpath/install.tar.gz -C  $wwwpath --strip-components 1 \
&& chown -R $ug $wwwpath \
&& rm $wwwpath/index.html \
&& rm $wwwpath/install.tar.gz 

WORKDIR /data
COPY resources $RESPATH/

RUN chmod +x /data/resources/entrypoint.sh


ENV httppath="http://localhost" \
    iliaspath="ilias" \
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
    initadminfirstname="foo" \
    initadminlastname="bar" \
    initadminemail="foobar@localhost" \
    initfeedbackemail="foobar@localhost"

ENV apachestartmode="FOREGROUND" \
    createdump="no" \
    restorefromdump="no"

EXPOSE 80 443   
        
ENTRYPOINT ["/data/resources/entrypoint.sh"]
