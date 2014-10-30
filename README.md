# vagrant-vms

This is a collection of Vagrant virtual machines used at FSU. Since the Vagrantfiles and init scripts are so small, it's a lot easier to keep them all in one place. All VMs are using 64 bit CentOS 5.6 to stay as close to our production environment as possible.

## Directory:
- centos: minimal CentOS instance with no special packages other than developer utilities (git, vim, tmux).
- centos-docker: built off of the core centos VM but with docker and golang installed, used the host VM for docker projects.
- centos-databox: build off of the core centos VM but with R and its dependencies installed, used for data analysis projects.
- newvm.sh: handy utility script for creating new VM projects based off of old ones.
