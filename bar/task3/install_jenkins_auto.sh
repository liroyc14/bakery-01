#this scripts need's to run as root
#!/usr/bin/env bash
which docker > /dev/null 2>&1
if [[ $? -eq 1 ]]; then
	#Installing Docker
        yum update -y
        yum install -q -y yum-utils
              yum-config-manager \
              --add-repo \
        echo "Install Docker"
        https://download.docker.com/linux/centos/docker-ce.repo
        yum -y install docker docker-ce docker-ce-cli containerd.io
        systemctl enable docker
        systemctl start docker
        systemctl is-active --quiet docker && echo Docker is running
else
        echo "docker installed"
fi
echo "
git:latest
github-api:latest
workflow-aggregator:latest
python:latest
pipeline-github-lib:latest
pipeline-stage-view:latest" > plugins.txt
echo "
unclassified:
  location:
    url: http://server_ip:8080/
jenkins:
  securityRealm:
    local:
      allowsSignup: false
      users:
       - id: ${JENKINS_ADMIN_ID}
         password: ${JENKINS_ADMIN_PASSWORD}" > casc.yaml		 
docker container inspect myjenkins > /dev/null 2>&1
#yum list installed | grep jenkins
if [[ $? -eq 1 ]]; then
	echo "FROM jenkins/jenkins:lts
	COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
	RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
	COPY casc.yaml /var/jenkins_home/casc.yaml
	ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
	ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false" > Dockerfile
        docker build -t jenkins:jcasc .
	docker run -d --name jenkins --rm -p 8080:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:jcasc		
else
        echo "jenkins installed"
fi
