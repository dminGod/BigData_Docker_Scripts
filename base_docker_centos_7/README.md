# Centos 7 Base Image With Common Utilities

This image has Centos 7 with these common utilities :

`tar openssh-server openssh-clients openssh wget vim sudo readline-devel iproute openssh-* initscripts vim wget curl lynx telnet nc nmap less man zlib-devel flex bison lsof git`

- group install of "Development Tools"
- epel
- Java 1.8
- Ansible

- Root password is set as "password"
- A sudo user bd is also created with the same password "password"

- The machine is able to SSH into itself with both the users -- This means you can make many instances of this machine and they will all SSH into each other for both the users without having to set this up.

## Usage
You can use the bootstrap.sh file standalone on a new machine/container or you can modify the bootstrap.sh file and build your own container.

to build a container, you will need to put the Dockerfile and bootstrap.sh  in the same folder and run this command :

`docker build -t <your_dockerhub_username>/<image_name> .`

On the -t is for the tag, you can use anything there.

This will execute script and you will be able to see your new docker container by using 

`docker images`


You can also directly just use this container by pulling it

`docker pull dmingod/installed_centos_7`

