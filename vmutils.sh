#!/usr/bin/env bash

CMD=$1

if [ "$1" == "" ]
then
  echo "Missing argument."
  exit
fi

case $1 in

  new)
  # Create a new VM project based on an existing one.
  # $2 is the project you want to base the new one on,
  # and $3 is the new project name (names folder and Vagrant machine name). 
  # Script ends editing the init script.
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
  # Dives into every VM project folder and outputs VM status.
    for VM in `ls`
    do
      if [ -f ./$VM/Vagrantfile ]
      then
        cd $VM; vagrant status | sed -n '3p'; cd ..
      fi
    done
    ;;

  halt)
  # Dives into every VM project folder, halts the VM, and returns the resulting status. 
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
  # like halt, but deadlier. Kill 'em all.
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
