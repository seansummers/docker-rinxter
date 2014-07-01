FROM java
MAINTAINER Sean Summers <seansummers@gmail.com>
ADD http://rinxter.com/dist/Rinxter-2.0.20140630.zip /
ENV RINXTER /root/Rinxter
ENV RINXTERBIN /root/2.0
WORKDIR /root
RUN apt-get update && apt-get -y install ttf-bitstream-vera unzip expect
RUN unzip /Rinxter-*.zip && rm -f /Rinxter-*.zip || exit 1
RUN expect -c 'spawn java -jar Rinxter-2.0.jar -console \
 while {1} { \
 expect { \
  "*redisplay*\r" { send "1\r" } \
  "*target path*\r" { send "\r"} \
  "*deselect:*\r" { send "0\r" } \
  eof { break } \
 } \
}' && rm -f Rinxter-2.0.jar || exit 2
RUN apt-get -y autoremove expect unzip && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir -p ${RINXTERBIN}/lib/ext && sed -i 's/\r//g' ${RINXTERBIN}/bin/*.sh && mkdir -p ${RINXTER}/temp
VOLUME /root/Rinxter
EXPOSE 8999
ENTRYPOINT PATH=${RINXTERBIN}/bin:${PATH} CATALINA_TMPDIR=${RINXTER}/temp rinxter.sh 
