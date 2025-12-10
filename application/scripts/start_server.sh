#!/bin/bash
# Ensure proper permissions
sudo chown -R apache:apache /var/www/html

# Restart Apache to apply changes
sudo systemctl restart httpd