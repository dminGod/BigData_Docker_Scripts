# Centos 6.6 Base Image With Common Utilities

This image has Centos 6.6 with these common utilities :
`tar openssh-server openssh-clients openssh wget vim sudo readline-devel iproute openssh-* initscripts vim wget curl lynx telnet nc nmap less man zlib-devel flex bison lsof`

- group install of "Development Tools"
- epel
- Java 1.8
- Ansible

- Root password is set as "password"
- A sudo user bd is also created with the same password "password"

- The machine is able to SSH into itself with both the users -- This means you can make many instances of this machine and they will all SSH into each other for both the users without having to set this up.

