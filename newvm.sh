#!/usr/bin/env bash

BASEVM=$1
NEWVM=$2

cp -r $BASEVM $NEWVM
perl -pi -e "s/\'$BASEVM\'/\'$NEWVM\'/" $NEWVM/Vagrantfile
vi $NEWVM/init.sh
