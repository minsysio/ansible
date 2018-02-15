#!/bin/bash 

#To update Ansible Directory after massive change - only SVN UPDATE + CP to ANSIBLE diretory 

#Q : lvi@minsys.io - hello 

ANSIBLE_CONF_DIR=/etc/ansible
ANSIBLE_CONFGIT_DIR=/opt/ansible
ANSIBLE_CONFGIT_TRUNK_DIR=$ANSIBLE_CONFGIT_DIR/trunk

echo "Local Repository upate"
cd $ANSIBLE_CONFGIT_DIR
svn update

echo "Copy Repository & last updated working configuration to Ansible Configuration Directory"
cp -r $ANSIBLE_CONFGIT_TRUNK_DIR/* $ANSIBLE_CONF_DIR