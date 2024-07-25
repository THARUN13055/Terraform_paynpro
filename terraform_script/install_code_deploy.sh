#!/bin/bash

sudo apt update -y
sudo apt install ruby-full -y
sudo apt install wget -y
sudo wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto
sudo apt install python3-pip -y
sudo python -m pip install awscli
sudo systemctl start codedeploy-agent
