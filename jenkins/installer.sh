#!/bin/bash 

###This file will install & configure the jenkins controller.

echo "Now checking for updates"
sleep 2
echo "Adding Jenkins Repo"
 sleep 1
 sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo
 sleep 1
 echo "Now Adding Jenkins key"
 sleep 2
 rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sleep 1
echo "checking for upgrades"
sleep 2
echo "Now Installing Java RUN TIME please wait. This might take a while"
sleep 2
yum install java* -y

echo "DONE"
sleep 3
clear
echo "Now Installing maven"
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
tar -xvzf apache-maven-3.9.6-bin.tar.gz
mv apache-maven-3.9.6 maven 
rm -rf apache-maven-3.9.6-bin.tar.gz
echo "DONE"
sleep 3
clear 
echo "Installing Jenkins"
yum install jenkins -y 
echo "DONE"
sleep 2
clear 
echo "Starting & Enabling Jenkins Deamon"
sleep 2
systemctl start jenkins && systemctl enable jenkins 
sleep 2 
echo "DONE"
clear
echo "Adding Jenkins & Maven Variables to .bash_profile"
sleep 2
sed -i '9i\JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-1.amzn2.0.1.x86_64"' /root/.bash_profile
sed -i '10i\M2_HOME="/opt/maven"' /root/.bash_profile
sed -i '9i\M2="/opt/maven/bin"' /root/.bash_profile

sed -i 's/^PATH=$PATH:$HOME\/bin/PATH=$PATH:$HOME\/bin:$JAVA_HOME:$M2_HOME:$M2/' /root/.bash_profile
source /root/.bash_profile 
echo "DONE"
sleep 3
clear
echo "The ADMIN password of the jenkins instance is: $(cat /var/lib/jenkins/secrets/initialAdminPassword)"


