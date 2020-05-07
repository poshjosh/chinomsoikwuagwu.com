#!/bin/bash
@echo off
echo "Re-start required after running this script."
echo "... Updating system"
sudo yum update -y
echo "... Installing docker"
sudo amazon-linux-extras install docker
echo "... Starting docker service"
sudo service docker start
echo "... Adding ec2 user to docker group"
sudo usermod -a -G docker ec2-user
echo "... Restarting docker"
sudo service docker restart
