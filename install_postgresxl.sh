#!/bin/bash
yum install -y  tar openssh-server openssh-clients openssh wget vim sudo readline-devel iproute openssh-* initscripts vim wget curl lynx telnet nc nmap less wget man zlib-devel flex bison lsof;
yum groupinstall -y "Development tools"
echo "%wheel        ALL=(ALL)       ALL" >> /etc/sudoers

adduser -G wheel postgres;
echo "password" | passwd postgres --stdin
echo "password" | passwd root --stdin

mkdir /opt;
cd /opt;
wget https://nchc.dl.sourceforge.net/project/postgres-xl/Releases/Version_9.5r1/postgres-xl-9.5r1.4.tar.gz;
tar -zxvf postgres-xl-9.5r1.4.tar.gz;

cd postgres-xl-9.5r1.4/
cd /opt/postgres-xl-9.5r1.4/;./configure; make; make install;
cd /opt/postgres-xl-9.5r1.4/contrib/pgxc_ctl; make; make install;
echo 'PATH=$PATH:/usr/local/pgsql/bin' >> ~/.bashrc; source ~/.bashrc;
