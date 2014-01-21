FROM zachlatta/docker-jvm
MAINTAINER Sean Summers <seansummers@gmail.com>
ADD http://rinxter.com/www/wp-content/uploads/2014/01/Rinxter-2.0.201401051.zip /
# 2013-01-20T18:43
ADD install.sh /
WORKDIR /root
RUN /install.sh
VOLUME /root/Rinxter
EXPOSE 8999
ENTRYPOINT PATH=/root/2.0/bin:${PATH} CATALINA_TMPDIR=/root/Rinxter/temp rinxter.sh 
