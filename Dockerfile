FROM seansummers/openjdk-7-jre-headless
MAINTAINER Sean Summers <seansummers@gmail.com>
ADD http://rinxter.com/dist/Rinxter-2.0.20140630.zip /
ENV LAST_UPDATED 2014-07-01T09:16
ADD install.sh /
WORKDIR /root
RUN /install.sh
VOLUME /root/Rinxter
EXPOSE 8999
ENTRYPOINT PATH=/root/2.0/bin:${PATH} CATALINA_TMPDIR=/root/Rinxter/temp rinxter.sh 
