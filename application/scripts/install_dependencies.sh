#!/bin/bash
# Install dependencies
sudo yum update -y
sudo yum install -y httpd

# Start Apache if not running
sudo systemctl start httpd
sudo systemctl enable httpd