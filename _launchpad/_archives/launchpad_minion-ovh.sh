#!/bin/bash

#To deploy a minion(xy)-ovh.minsys.cloud ONLY
#Q : lvi@minsys.io

ANSIBLE_CONF_DIR=/etc/ansible
ANSIBLE_INVENTORY_DIR=$ANSIBLE_CONF_DIR/inventory
ANSIBLE_PLAYBOOKS_DIR=$ANSIBLE_CONF_DIR/playbooks/deploy_minion_cloud
ANSIBLE_CONFGIT_DIR=/opt/ansible
ANSIBLE_CONFGIT_TRUNK_DIR=$ANSIBLE_CONFGIT_DIR/trunk
LAUNCHPAD_DIR=$ANSIBLE_CONFGIT_TRUNK_DIR/_launchpad 

echo "Local Repository upate"
cd $ANSIBLE_CONFGIT_DIR
svn update
echo "Copy Repository = last updated working configuration, to Ansible Configuration Directory -> $ANSIBLE_CONF_DIR"
chmod u+x $LAUNCHPAD_DIR/launchpad_minion-ovh.sh
cp -r $ANSIBLE_CONFGIT_TRUNK_DIR/* $ANSIBLE_CONF_DIR
:> /root/.ssh/known_hosts
read -p 'Enter the ++MINION++ IP address  : ' ip_minion
#Need Control structure for OVH / Other provider -> changing "ansible_ssh_user= && base_minion_cloud=$Provider
echo "Ansible Inventory Initilization"
#echo "[base_minion_cloud]\n$ip_minion\n[base_minion_cloud:vars]\nansible_user= ubuntu\nansible_ssh_private_key_file= /root/.ssh/ansible_rsa\nansible_python_interpreter=/usr/bin/python3" > $ANSIBLE_INVENTORY_DIR/hosts
(
  echo [test_pod01]
  echo "$ip_minion"
  echo [test_pod01:vars]
  echo host_key_checking= False
  echo ansible_user= ubuntu
  echo ansible_ssh_private_key_file= /root/.ssh/ansible_rsa
  echo ansible_python_interpreter=/usr/bin/python3
) > $ANSIBLE_INVENTORY_DIR/hosts

echo "Launch Ansible PLAYBOOK for minion : $ip_minion"
ansible-playbook $ANSIBLE_PLAYBOOKS_DIR/deploy_ovh.yml 
exit
