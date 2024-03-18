#!/bin/bash

# Install Apache
sudo yum install httpd -y

# Create directory /var/www/html/sa
sudo mkdir -p /var/www/html/sa

# Create a basic HTML file in the directory for testing
echo "<html><body><h1>Welcome in Abdelsalam Website ^^</h1></body></html>" | sudo tee /var/www/html/sa/index.html >/dev/null

# Create Apache configuration file /etc/httpd/conf.d/sa.conf
sudo bash -c 'cat <<EOF > /etc/httpd/conf.d/sa.conf
<Directory /var/www/html/sa>
    AllowOverride All
    Require all granted
</Directory>
EOF'

# Install Apache utilities for managing .htaccess files
sudo yum install httpd-tools -y

# Create .htpasswd file for authentication
sudo htpasswd -c /etc/httpd/.htpasswd moabslam

# Create .htaccess file with authentication
sudo bash -c 'cat <<EOF > /var/www/html/sa/.htaccess
AuthType Basic
AuthName "Restricted Access"
AuthUserFile /etc/httpd/.htpasswd
Require valid-user
EOF'

# Restart Apache to apply changes
sudo systemctl restart httpd

