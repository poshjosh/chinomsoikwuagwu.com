Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
# See https://aws.amazon.com/premiumsupport/knowledge-center/execute-user-data-ec2/
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash
#https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html
@echo off
echo "... Starting docker"
sudo service docker start
echo "... Creatin volume: jenkins-data"
sudo docker volume create jenkins-data
echo "... Running container: jenkins"
sudo docker run --name jenkins-lts --rm --detach --privileged -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v $(which docker):/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME":/home poshjosh/jenkins:lts
echo "... Creating sonarqube volumes"
sudo docker volume create --name sonarqube_data
sudo docker volume create --name sonarqube_extensions
sudo docker volume create --name sonarqube_logs
echo "... Running container: sonarqube"
sudo docker run --name sonarqube --rm --detach -p 9000:9000 -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions -v sonarqube_logs:/opt/sonarqube/logs sonarqube
--//
