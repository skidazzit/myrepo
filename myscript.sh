#!/bin/bash

#Set variables 
command1=dnf
command2=firewalld
command3=httpd

#update and upgrade current yum packages
sudo yum update -y && sudo yum upgrade -y

#install dnf package manager
if command -v $command1
then
     echo "$command1 is available, let's run it..."
else
     echo "$command1 is NOT available, installing it..."
     sudo yum install $command1 -y
fi

#check if Firewalld is installed. If not Install Firewalld
if command -v $command2
then
     echo "$command2 is available, let's run it..."
else
     echo "$command2 is NOT available, installing it..."
     sudo dnf install $command2 -y
fi    
sudo systemctl enable firewalld

#check if Apache is installed. If not Install Apache
if command -v $command3
then
     echo "$command3 is available, let's run it..."
else
     echo "$command3 is NOT available, installing it..."
     sudo dnf install $command3
fi
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
sudo systemctl enable httpd

#NagiosXI installtion
#curl https://assets.nagios.com/downloads/nagiosxi/install.sh | sh