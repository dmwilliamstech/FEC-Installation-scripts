#!/bin/bash


########################################
###This is a script to install Gitlab###
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
echo '#------------------------------------#'
echo '#  Oracle GitLab Installation Script #'
echo '#------------------------------------#'
clear

echo "Please enter the desired GitLab IP"
read git_ip
echo "/nPlease enter the desired GitLab Port"
read git_port

echo "Updates packages. Asks for your password."
yum -y update

# function isinstalled {
#   if yum list installed "$@" >/dev/null 2>&1; then
#     return 1
#   else
#     return 0
#   fi
# }
echo "Installing openssh-server"
yum install -y openssh-server

echo "Installing and configuring Postfix"
service postfix start
chkconfig postfix on

echo "Installing cronie"
yum install cronie

echo "Retrieving and installing GitLab rpm"
RPM_FILE=gitlab-ce-7.10.4~omnibus-1.x86_64.rpm
cd /tmp && wget https://downloads-packages.s3.amazonaws.com/centos-7.1.1503/gitlab-ce-7.10.4~omnibus-1.x86_64.rpm
if [ -f /tmp/$RPM_FILE ];
then
  echo "Installing GitLab rpm"
  cd /tmp && rpm -ivh $RPM_FILE
else
  echo "This '$RPM_FILE' is missing"
fi

echo "Configure Gitlab to run on desired IP and Port"
GITLAB_CONFIG=/etc/gitlab/gitlab.rb
if [ ! -z "$git_port" ];
	then
	EXTERNAL_URL=$git_ip\:$git_port
	if [ -f $GITLAB_CONFIG ];
	then
	  echo "Configuring GitLab URL and Port"
	  sed -i "s/localhost/$EXTERNAL_URL/g" $GITLAB_CONFIG
	else
	  echo "This '$GITLAB_CONFIG' is missing"
	fi
else
	echo "No port enter so default is 8080"
	if [ -f $GITLAB_CONFIG ];
		EXTERNAL_URL=$git_ip\:8080
	then
	  echo "Configuring GitLab URL and Port"
	  sed -i "s/localhost/$EXTERNAL_URL/g" $GITLAB_CONFIG
	else
	  echo "This '$GITLAB_CONFIG' is missing"
	fi
fi

echo "Restarting the gitlab-ctl"
  gitlab-ctl reconfigure

echo "Access GitLab using the following URL ${git_ip}:${git_port}"
echo "To log into GitLab locally use the following credentials"
echo "username: root"
echo "password: 5iveL!fe"
echo "Upon first login changing the password is required. You will need to enter the current password then the desired new password"
