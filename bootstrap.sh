#!/bin/bash

#Step 1 - Update CentOS 7 system
echo "Updating system"
sudo yum -y install epel-release
sudo yum -y update
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

#Install Docker
echo "Installing Docker"
sudo yum -y install docker docker-ce docker-ce-cli containerd.io
which docker
if [[ $? -eq 0 ]]; then
  echo "Docker installation succeeded"
else
  echo "Docker installation failed"
fi

#For Jenkins Installation:
#Install Java:
echo "Installing java..."
sudo yum -y install java-1.8.0-openjdk.x86_64
#Set environment variables:
echo "Adding environment variables"
sudo cp /etc/profile /etc/profile_backup #Backup /etc/profile
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile
#Install Jenkins
echo "Installing jenkins"
cd ~
which wget
if [[ $? -eq 1 ]]; then
  echo "Installing wget..."
  sudo yum -y install wget
fi
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins && echo "Jenkins Installation succeeded"

echo "Goodbye"

