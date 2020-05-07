#/bin/sh
yum update -y
yum install docker -y
service docker start
usermod -aG docker ec2-user
mv /tmp/docker /etc/sysconfig/docker
chmod 644 /etc/sysconfig/docker
service docker restart
mv /tmp/default-user.groovy ./default-user.groovy
mv /tmp/Dockerfile ./Dockerfile
mv /tmp/jenkins-plugins ./jenkins-plugins
docker build -t poshjosh/jenkins:lts .
docker volume create jenkins-data
docker run --name jenkins-lts --rm --detach --privileged -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v $(which docker):/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME":/home poshjosh/jenkins:lts
# https://docs.sonarqube.org/latest/setup/install-server/
# https://hub.docker.com/_/sonarqube
sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536
ulimit -n 65536
ulimit -u 4096
sudo docker run --name sonarqube --rm --detach -p 9000:9000 -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions -v sonarqube_logs:/opt/sonarqube/logs sonarqube
