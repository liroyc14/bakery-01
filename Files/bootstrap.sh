sudo yum update -y
#Install Docker
which docker
if [[ $? -eq 1 ]]; then
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        sudo yum install -y docker-ce docker-ce-cli containerd.io
        sudo systemctl enable docker
        sudo systemctl start docker
else
        echo "docker installed"
fi

#Install wget
which wget
if [[ $? -eq 1 ]]; then
        sudo yum install -y wget
else
        echo "wget installed"
fi
#install Jenkins
systemctl is-active --quiet jenkins
if  service --status-all | grep -Fq 'jenkins' ; then
        echo "Jenkins installed"
else
        sudo wget -O /etc/yum.repos.d/jenkins.repo \
            https://pkg.jenkins.io/redhat-stable/jenkins.repo
        sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
        sudo yum upgrade -y
        sudo yum install jenkins java-1.8.0-openjdk-devel -y
        sudo systemctl daemon-reload
#start Jenkins
        sudo systemctl start jenkins
        echo $(cat /var/lib/jenkins/secrets/initialAdminPassword) >> ~/adminpass.txt
fi
echo "Done!"
