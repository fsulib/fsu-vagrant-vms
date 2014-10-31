# centos-docker

centos-docker is a minimal 64 bit CentOS v6.5 Vagrant VM used as a sandbox for playing around with Docker. Docker is installed and the service is started on initialization, check `init.sh` for details about what gets installed during the boot process.

## Notes:
`docker search imagename` searches docker hub for images matching 'imagename'
`docker pull imagename` pulls a specific image from docker hub into the daemon
`docker ps` lists running containers
`docker ps -a` lists all containers (running or stopped)
`docker run -it imagename /bin/bash` opens a bash shell inside the 'imagename' container
`docker run -d -p 80:5000 imagename startapp` runs imagename into a container and maps container port 5000 to host port 80 (host being the Vagrant VM)
