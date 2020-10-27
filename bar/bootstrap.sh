#!/usr/bin/bash
sudo yum -y install git
ssh-keygen -t rsa -b 4096
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
ssh -T git@github.com
sudo yum install -q -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker docker-ce docker-ce-cli containerd.io
sudo service docker start
sudo yum -y install lsof
sudo sed -i "266i jenkins-port    8080/tcp                        #Application_Jenkins" /etc/services
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
sudo docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:5000$
sudo docker exec -u root -it laughing_engelbart /bin/bash
cat /var/jenkins_home/secrets/initialAdminPassword
