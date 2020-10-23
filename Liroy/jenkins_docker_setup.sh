#!/usr/bin/env bash

echo "Setting up jenkins Dockerfile..."
echo "git:latest" > plugins.txt
echo "github-api:latest" >> plugins.txt
echo "workflow-aggregator:latest" >> plugins.txt
echo "python:latest" >> plugins.txt

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

echo "FROM jenkins/jenkins:lts

# Install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Copy Jenkins config as code
COPY casc.yaml /var/jenkins_home/casc.yaml

# Set java options.
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false" > Dockerfile

docker build -t jenkins:jcasc .
docker run -d --name jenkins --rm -p 8080:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:jcasc

