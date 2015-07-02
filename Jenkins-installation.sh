
#!/bin/bash


########################################
###This is a script to install Jenkins###
####on a Oracle Linux/ CentOS/Redhat####
########################################
#
# Author:
#   David Williams <dwilliams@fec.gov>
#
# Description:
#   An installation bash script



tabs 4
echo ''
echo '#-----------------------------------------#'
echo '#     Oracle Jenkins Installation Script  #'
echo '#-----------------------------------------#'
clear

echo "Updates packages."
yum -y update

echo "Downloading jenkins.repo file"
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
echo "Importing jenkins.repo file"
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
echo "Yum installing jenkins"
yum install jenkins
echo "Starting jenkins"
service jenkins start
echo "Configuring Jenkins to start on boot-up"
chkconfig jenkins on
