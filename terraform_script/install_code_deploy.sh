#!/bin/bash

sudo apt update -y
sudo apt install ruby-full -y
sudo apt install wget -y
sudo wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto
#It will test Wether the application install or not.
check_codedeploy() {
    if systemctl list-units --type=service | grep -q 'codedeploy-agent'; then
        echo "CodeDeploy agent is already installed and running."
        return 0
    else
        return 1
    fi
}

# Install CodeDeploy agent if not already installed
if check_codedeploy; then
    echo "Skipping installation as CodeDeploy is already installed."
else
    echo "Installing CodeDeploy agent..."
    sudo wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
    sudo chmod +x ./install
    sudo ./install auto

    # Verify installation
    if check_codedeploy; then
        echo "CodeDeploy agent installed successfully."
    else
        echo "Failed to install CodeDeploy agent."
        exit 1
    fi
fi

# It will install the packages using python
sudo apt install python3-pip -y
sudo python -m pip install awscli

# It is used for starting the agent of code-deploy
sudo systemctl start codedeploy-agent

# It is just for verification.
if command systemctl is-active codedeploy-agent; then
  echo "Its working fine"
else
  sudo systemctl start codedeploy-agent
fi