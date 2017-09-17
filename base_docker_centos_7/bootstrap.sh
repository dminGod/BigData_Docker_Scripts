#!/bin/sh
# Update and install the common stuff..
yum -y update
yum install -y tar openssh-server openssh-clients openssh wget vim sudo readline-devel iproute openssh-* initscripts vim wget curl lynx telnet nc nmap less man zlib-devel flex bison lsof gcc tcl make git
yum groupinstall -y "Development tools"

# Install Java, epel repo and ansible
cd /opt

wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz

rpm -ivh epel-release-7-10.noarch.rpm

# Install Ansible
yum install ansible

# Install Java
tar -zxvf jdk-8u144-linux-x64.tar.gz

cd jdk1.8.0_144

alternatives --install /usr/bin/java java /opt/jdk1.8.0_144/bin/java 1;
alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_144/bin/jar 1;
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_144/bin/javac 1;
alternatives --set jar /usr/bin/jar;
alternatives --set javac /usr/bin/javac;

java -version

# Set password for root
echo "password" | passwd root --stdin
ssh-keygen -t rsa

# Create a id file for the root user. We will use the same one for the other use also
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
chkconfig sshd on

# SSH Into own self
cat $HOME/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# Create the wheel user
adduser -G wheel bd
echo "password" | passwd bd --stdin

# Add the wheel group to sudoers. This image does not have it on by default
echo "%wheel        ALL=(ALL)       ALL" >> /etc/sudoers

# Make the directory in case it isn't there
mkdir /home/bd/.ssh

# We will use the same keys of the root for the bd guy as well
cp /root/.ssh/id_rsa /home/bd/.ssh/id_rsa
cp /root/.ssh/id_rsa.pub /home/bd/.ssh/id_rsa.pub
cp /root/.ssh/authorized_keys /home/bd/.ssh/authorized_keys

chown -R bd:bd /home/bd/.ssh

