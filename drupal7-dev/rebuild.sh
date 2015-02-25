#!/bin/sh

# Kill old VM
vagrant destroy --force

# Get latest backup from private FSU server
CURDIR=`pwd`
/usr/bin/su - backrest -c "scp backrest@lib-srv-webdev01.lib.fsu.edu:~/dev/FSULibraries_latest.sitearchive.tar /tmp/backup.tar"
mv /tmp/backup.tar $CURDIR/dependencies/
tar -xvzf $CURDIR/dependencies/backup.tar -C $CURDIR/dependencies/

# Build VM
vagrant up
