FROM zachlatta/docker-jvm

MAINTAINER Sean Summers <seansummers@gmail.com>

ADD http://rinxter.com/www/wp-content/uploads/2014/01/Rinxter-2.0.201401051.zip /root/
ADD fix-rinxter.sh /root/

WORKDIR /root
RUN ./fix-rinxter.sh

VOLUME /root/Rinxter
EXPOSE 8999

ENTRYPOINT PATH=/root/2.0/bin:${PATH} CATALINA_TMPDIR=/root/Rinxter/temp rinxter.sh 

