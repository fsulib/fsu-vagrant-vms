#!/usr/bin/env bash

# Install core utils
yum -y install vim
yum -y install git 
yum -y install tmux

# Install docker utils
yum update -y device-mapper-libs
yum -y install epel-release
yum -y install docker-io
service docker start
