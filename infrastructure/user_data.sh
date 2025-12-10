#!/bin/bash
# Update system and install dependencies
sudo yum update -y
sudo yum install -y httpd

# Get region from instance metadata
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')

# Install CodeDeploy Agent
sudo yum install -y ruby
cd /home/ec2-user
wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Create basic index page
sudo echo "<html><body><h1>Hello from ${environment} environment!</h1><p>Instance IP: $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</p></body></html>" > /var/www/html/index.html

# Ensure proper permissions
sudo chown -R apache:apache /var/www/html