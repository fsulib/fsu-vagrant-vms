#!/usr/bin/env bash

CMD=$1

if [ "$1" == "" ]
then
  echo "Missing argument."
  exit
fi

case $1 in
  new)
    BASEVM=$2
    NEWVM=$3
    if [ -d $BASEVM ]; then
      cp -r $BASEVM $NEWVM
      perl -pi -e "s/\'$BASEVM\'/\'$NEWVM\'/" $NEWVM/Vagrantfile
      vi $NEWVM/init.sh
    else
      echo "ERROR: Base VM '$BASEVM' does not exist." 
    fi
    ;;
  check)
    for VM in `ls`
    do
      if [ -f ./$VM/Vagrantfile ]
      then
        cd $VM; vagrant status | sed -n '3p'; cd ..
      fi
    done
    ;;
  halt)
    for VM in `ls`
    do
      if [ -f ./$VM/Vagrantfile ]
      then
        cd $VM; vagrant halt; cd ..
        cd $VM; vagrant status | sed -n '3p'; cd ..
      fi
    done
    ;;
  destroy)
    for VM in `ls`
    do
      if [ -f ./$VM/Vagrantfile ]
      then
        cd $VM; vagrant destroy; cd ..
        cd $VM; vagrant status | sed -n '3p'; cd ..
      fi
    done
    ;;
  *)
    echo "Unknown argument."
    ;;
esac
