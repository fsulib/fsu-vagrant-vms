#!/usr/bin/env bash

BASEVM=$1
NEWVM=$2

if [ -d $BASEVM ]; then
  cp -r $BASEVM $NEWVM
  perl -pi -e "s/\'$BASEVM\'/\'$NEWVM\'/" $NEWVM/Vagrantfile
  vi $NEWVM/init.sh
else
  echo "ERROR: Base VM '$BASEVM' does not exist." 
fi
