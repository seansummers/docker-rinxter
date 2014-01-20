FROM zachlatta/docker-jvm

MAINTAINER Sean Summers <seansummers@gmail.com>

##original messy source
# ADD http://rinxter.com/www/wp-content/uploads/2014/01/Rinxter-2.0.201401051.zip /root/
# cd /root/Rinxter/2.0
# mkdir -p temp lib/ext
# perl -pi -e 's/\r//g' bin/*.sh

## fix imgs to be under the data directory
# perl -pi -e 's/Rinxter\/imgs/Rinxter\/data\/imgs/g' conf/Catalina/localhost/*.xml
# mkdir -p ../data/temp && mv ../imgs ../data/

# installed and all the above patches made
ADD Rinxter-2.0.201401051-installed.tar.xz /root/

WORKDIR /root/Rinxter

VOLUME /root/Rinxter/data
EXPOSE 8999

ENTRYPOINT PATH=/root/Rinxter/2.0/bin:${PATH} CATALINA_TMPDIR=/root/Rinxter/data/temp rinxter.sh 

