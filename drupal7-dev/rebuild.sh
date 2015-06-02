#!/bin/sh

if [ "$(id -u)" != "0"  ]; then
  echo "Don't forget to sudo!" 1>&2
  exit 1
fi

U=`basename $( echo $HOME )`
CURDIR=`pwd`

echo "\nDestroying old VM..."
/usr/bin/su - $U -c "cd $CURDIR; vagrant destroy --force"

echo "\nGetting Omega backup..."
/usr/bin/su - backrest -c "scp backrest@lib-srv-webdev01.lib.fsu.edu:~/backhand/FSULibraries_backrest.sitearchive.tar.gz /tmp/backup.tar.gz"
gunzip /tmp/backup.tar.gz
mv /tmp/backup.tar $CURDIR/dependencies/

echo "\nExtracting backup..."
tar -xvzf $CURDIR/dependencies/backup.tar -C $CURDIR/dependencies &> /dev/null

echo "\nSpinning up new VM..."
/usr/bin/su - $U -c "cd $CURDIR; vagrant up"
echo "\033[0;31;5mDone! drupal7-dev now live @ localhost:9999\033[0m"
