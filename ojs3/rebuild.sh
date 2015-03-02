#!/usr/bin/env bash

OJSVERSION='3.0a1'
if [ ! -f "./dependencies/ojs-$OJSVERSION.tar.gz" ]; then
  wget -O ./dependencies/ojs-$OJSVERSION.tar.gz http://pkp.sfu.ca/ojs/download/ojs-$OJSVERSION.tar.gz
  tar -xvzf ./dependencies/ojs-$OJSVERSION.tar.gz -C ./dependencies/ &> /dev/null
  mv ./dependencies/ojs-$OJSVERSION ./dependencies/ojs
fi

vagrant destroy --force
vagrant up
