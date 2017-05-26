#!/bin/bash

ANSIBLE_CONF_DIR=/etc/ansible
ANSIBLE_CONFGIT_DIR=/opt/ansible/github
ANSIBLE_CONFGIT_TRUNK_DIR=$ANSIBLE_CONFGIT_DIR/trunk
#LAUNCHPAD_DIR=$ANSIBLE_CONFGIT_TRUNK_DIR/_launchpad 

cd $ANSIBLE_CONFGIT_DIR
svn update
cp -R $ANSIBLE_CONFGIT_TRUNK_DIR/* $ANSIBLE_CONF_DIR
:> /root/.ssh/known_hosts
#chmod u+x $LAUNCHPAD_DIR/base_minion_cloud.sh
#sh $LAUNCHPAD_DIR/base_minion_cloud.sh
read -p 'Enter the new host/minion ip adress  : ' ip_minion
#Control structure pour OVH / Other provider -> changing "ansible_ssh_user= && base_minion_cloud=$Provider
echo "[base_minion_cloud]\n$ip_minion\n[base_minion_cloud:vars]\nhost_key_checking= False\nansible_ssh_user= ubuntu\nansible_ssh_private_key_file= /root/.ssh/ansible_rsa " > /etc/ansible/inventories/cloud.minsys.io/hosts
#ansible-playbook /etc/ansible/playbooks/base_system_cloud/deploy_ovh
exit
