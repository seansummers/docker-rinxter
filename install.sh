#!/bin/sh

RINXTER=/root/Rinxter
RINXTERBIN=${RINXTER}/../2.0

# prep apt-get
echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# unzip Rinxter and install...
apt-get -y install unzip expect
unzip /Rinxter-*.zip && rm -f /Rinxter-*.zip || exit 1

# install fonts needed for pdf reports
apt-get -y install ttf-dejavu ttf-liberation

expect -c 'spawn java -jar Rinxter-2.0.jar -console
while {1} {
 expect {
  "*redisplay*\r" { send "1\r" }
  "*target path*\r" { send "\r"}
  "*deselect:*\r" { send "0\r" }
  eof { break }
 }
}' && rm -f Rinxter-2.0.jar || exit 2

# clean up
apt-get -y autoremove expect unzip
apt-get autoclean
rm -rf /var/lib/apt/lists/*

# add missing directories
mkdir -p ${RINXTERBIN}/lib/ext

# fix script line endings
perl -pi -e 's/\r//g' ${RINXTERBIN}/bin/*.sh

# create temp in the data volume so that rinxter's hard-link-upload-to-destination trick works
mkdir -p ${RINXTER}/temp

# remove myself
rm -f /install.sh

# FIXME
# don't fall for this -- it's the wrong version
#apt-get -y install libtcnative-1
