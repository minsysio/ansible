#!/bin/bash

ANSIBLE_CONF_DIR=/etc/ansible
ANSIBLE_CONFGIT_DIR=/opt/ansible
ANSIBLE_CONFGIT_TRUNK_DIR=$ANSIBLE_CONFGIT_DIR/trunk
LAUNCHPAD_DIR=$ANSIBLE_CONFGIT_TRUNK_DIR/_launchpad 

cd $ANSIBLE_CONFGIT_DIR
svn update
cp -R $ANSIBLE_CONFGIT_TRUNK_DIR/* $ANSIBLE_CONF_DIR
chmod u+x $LAUNCHPAD_DIR/launchpad.sh
:> /root/.ssh/known_hosts
read -p 'Enter the new host/minion ip adress  : ' ip_minion
#Need Control structure for OVH / Other provider -> changing "ansible_ssh_user= && base_minion_cloud=$Provider
echo "[base_minion_cloud]\n$ip_minion\n[base_minion_cloud:vars]\nansible_user= ubuntu\nansible_ssh_private_key_file= /root/.ssh/ansible_rsa\nansible_python_interpreter=/usr/bin/python3" > /etc/ansible/inventories/cloud.minsys.io/hosts
ansible-playbook /etc/ansible/playbooks/base_minion_cloud/deploy_ovh.yml 
exit
