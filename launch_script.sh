#!/bin/bash
echo "### AIRFLOW INSTALLATION AND SETUP"
echo "------------------------------------"
echo "Updating system and installing preliminary files..."
echo "------------------------------------"
## System
sudo apt-get -y update
sudo apt-get -y install \
ca-certificates \
curl \
gnupg \
unzip \
make \
git
echo "------------------------------------"
echo "System Updated. Starting Docker installation..."
echo "------------------------------------"
## Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -y update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Running test image to ensure correct installation"
sudo docker run hello-world
echo "------------------------------------"
echo "Docker Installed successfully. Starting Airflow setup..."
echo "------------------------------------"
echo "Cloning airflow repo into box..."
repo_name=echo "${airflow_repo}" | grep -oP '\/([^\/]+)\.git$|\/([^\/]+)$'
cd /home/admin && git clone ${airflow_repo} && cd $repo_name
echo 'Setup Airflow environment variables'
echo ${env_file_string} > env
echo 'Starting Airflow containers...'
${airflow_make_command}
echo "### AIRFLOW INSTALLATION AND SPIN UP FINISHED"