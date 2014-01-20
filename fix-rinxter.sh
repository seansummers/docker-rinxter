#!/bin/sh

RINXTER=/root/Rinxter
RINXTERBIN=${RINXTER}/../2.0

# prep apt-get
echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# unzip Rinxter and install...
apt-get -y install unzip expect
unzip Rinxter-*.zip || exit 1

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
mkdir -p ${RINXTERBIN}/lib/ext

# fix line endings
perl -pi -e 's/\r//g' ${RINXTERBIN}/bin/*.sh

# create temp in the data volume so that upload hard-link-to-target trick works for rinxter
mkdir -p ${RINXTER}/temp

# install fonts needed for pdf reports
apt-get -y install ttf-dejavu ttf-liberation

# don't fall for this, it's the wrong version
#apt-get -y install libtcnative-1

# clean up
apt-get -y autoremove expect unzip
rm -rf /var/lib/apt/lists/*
rm -f Rinxter-*.zip Rinxter-*.jar

# remove myself
rm -f ${0}

