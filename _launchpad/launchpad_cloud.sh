#!/bin/bash

#To deploy a cloud.minsys.io's MINION ready. For forge.minsys.io refer to launchpad_forge.sh
#Q : lvi@minsys.io

ANSIBLE_CONF_DIR=/etc/ansible
ANSIBLE_INVENTORY_DIR=$ANSIBLE_CONF_DIR/inventory
ANSIBLE_PLAYBOOKS_DIR=$ANSIBLE_CONF_DIR/playbooks/base_minion_cloud
ANSIBLE_CONFGIT_DIR=/opt/ansible
ANSIBLE_CONFGIT_TRUNK_DIR=$ANSIBLE_CONFGIT_DIR/trunk
LAUNCHPAD_DIR=$ANSIBLE_CONFGIT_TRUNK_DIR/_launchpad 


cd $ANSIBLE_CONFGIT_DIR
svn update
cp -R $ANSIBLE_CONFGIT_TRUNK_DIR/* $ANSIBLE_CONF_DIR
chmod u+x $LAUNCHPAD_DIR/launchpad_cloud.sh
:> /root/.ssh/known_hosts
read -p 'Enter the ++MINION++ IP address  : ' ip_minion
#Need Control structure for OVH / Other provider -> changing "ansible_ssh_user= && base_minion_cloud=$Provider
echo "[base_minion_cloud]\n$ip_minion\n[base_minion_cloud:vars]\nansible_user= ubuntu\nansible_ssh_private_key_file= /root/.ssh/ansible_rsa\nansible_python_interpreter=/usr/bin/python3" > $ANSIBLE_INVENTORY_DIR/hosts
ansible-playbook $ANSIBLE_PLAYBOOKS_DIR/deploy_ovh.yml 
exit
