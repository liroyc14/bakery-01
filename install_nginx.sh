#!/bin/bash

which nginx &> /dev/null
if [[ $? -eq 0 ]]; then
  read -p "nginx is already installed. Would you like to uninstall it? [y/n]" user_answer
  if [[ $user_answer == "y" ]]; then
    # Stop Nginx service and remove Nginx auto start script
    sudo systemctl stop nginx.service
    sudo systemctl disable nginx.service
    # Remove Nginx user and it related directory
    sudo userdel -r nginx
    # Delete and related Nginx installation directory
    sudo rm -rf /etc/nginx
    sudo rm -rf /var/log/nginx
    sudo rm -rf /var/cache/nginx/
    # Remove the created nginx.service script under systemd
    sudo rm -rf /usr/lib/systemd/system/nginx.service
    # Remove the installed package
    sudo yum erase -y nginx
  elif [[ $user_answer == "n" ]]; then
    echo "Goodbye"
  else
    echo "Invalid answer was given. Exiting..."
  fi    
else
  read -p "nginx is not installed. Would you like to install it? [y/n]" user_answer
  if [[ $user_answer == "y" ]]; then
    sudo yum install -y epel-release
    sudo yum install -y nginx && echo "nginx installed successfully"
    sudo systemctl enable nginx && echo "nginx will start on boot"
    sudo systemctl start nginx && echo "nginx is running."
  elif [[ $user_answer == "n" ]]; then
    echo "Goodbye"
  else
    echo "Invalid answer was given. Exiting..."
  fi
fi
