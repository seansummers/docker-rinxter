#!/bin/sh

RINXTER=/root
RINXTERV=${RINXTER}/2.0

cd ${RINXTER}

# prep apt-get
echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# unzip Rinxter and install...
apt-get -y install unzip expect
unzip Rinxter-*.zip
expect -c 'spawn java -jar Rinxter-2.0.jar -console
while {1} {
 expect {
  "*redisplay*\r" { send "1\r" }
  "*target path*\r" { send "\r"}
  "*deselect:*\r" { send "0\r" }
  eof { break }
 }
}'

# add missing directories
mkdir -p ${RINXTERV}/lib/ext

# fix line endings
perl -pi -e 's/\r//g' ${RINXTERV}/bin/*.sh

## move imgs to be under the data directory
perl -pi -e 's/Rinxter\/imgs/Rinxter\/data\/imgs/g' ${RINXTERV}/conf/Catalina/localhost/*.xml
mv ${RINXTER}/imgs ${RINXTER}/data/

# create temp in the data volume so that upload hard-link-to-target trick works for rinxter
mkdir -p ${RINXTER}/data/temp

# install fonts needed for pdf reports
apt-get -y install ttf-dejavu ttf-liberation

# don't fall for this, it's the wrong version
#apt-get -y install libtcnative-1

# clean up
apt-get -y remove expect unzip
rm -rf /var/lib/apt/lists/*
rm -f Rinxter-*.zip

