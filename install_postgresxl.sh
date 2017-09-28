#!/bin/sh
# Update and install the common stuff..
yum -y update
yum install -y tar openssh-server openssh-clients openssh wget vim sudo readline-devel iproute openssh-* initscripts vim wget curl lynx telnet nc nmap less man zlib-devel flex bison lsof gcc tcl make git
yum groupinstall -y "Development tools"

# Install Java, epel repo and ansible
cd /opt

wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz

rpm -ivh epel-release-6-8.noarch.rpm

# Install Ansible, we will use this later for controlling the machiens from a single place..
yum install ansible

# Install Java, just in case we need it... don't need it really....
tar -zxvf jdk-8u144-linux-x64.tar.gz

cd jdk1.8.0_144

alternatives --install /usr/bin/java java /opt/jdk1.8.0_144/bin/java 1;
alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_144/bin/jar 1;
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_144/bin/javac 1;
alternatives --set jar /usr/bin/jar;
alternatives --set javac /usr/bin/javac;

java -version

# Set password for root so we can ssh from one machine to other if we want
echo "password" | passwd root --stdin
ssh-keygen -t rsa

# Now we will do passwordless ssh for root and postgres user. We are going to do the passwordless ssh to the node itself.
# This means that when new nodes are created in this same way a copy of this server they all will be able to SSH into each other.
# DO NOT run the keygen steps on all the machines, generate the identity file for one machine and use the same file for all the other machines.
# (This is for making life easy -- you are not supposed to do this in production!)
# Create a id file for the root user. We will use the same one for the other use also
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
chkconfig sshd on

# SSH Into own self
cat $HOME/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# Create the wheel user
adduser -G wheel postgres
echo "password" | passwd postgres --stdin

# Add the wheel group to sudoers. This image does not have it on by default
echo "%wheel        ALL=(ALL)       ALL" >> /etc/sudoers

# Make the directory in case it isn't there
mkdir /home/postgres/.ssh

# We will use the same keys of the root for the bd guy as well
cp /root/.ssh/id_rsa /home/bd/.ssh/id_rsa
cp /root/.ssh/id_rsa.pub /home/postgres/.ssh/id_rsa.pub
cp /root/.ssh/authorized_keys /home/postgres/.ssh/authorized_keys

chown -R postgres:postgres /home/bd/.ssh

# INSTALL OF PGXL -- STARTS FROM HERE
mkdir /opt;
cd /opt;
wget https://nchc.dl.sourceforge.net/project/postgres-xl/Releases/Version_9.5r1/postgres-xl-9.5r1.4.tar.gz;
tar -zxvf postgres-xl-9.5r1.4.tar.gz;

cd postgres-xl-9.5r1.4/

# Run as Postgres user : cd /opt/postgres-xl-9.5r1.4/;sudo ./configure; sudo make; 

# Run as Root : make install;

# Run as Postgres user : cd /opt/postgres-xl-9.5r1.4/contrib/pgxc_ctl; sudo make; 

# Run as Root : make install;

# echo 'PATH=$PATH:/usr/local/pgsql/bin' >> ~/.bashrc; source ~/.bashrc;

# Make the IP address of this server hard-coded if you are using docker, because once you do restarts and the IP changes, it will not work.
