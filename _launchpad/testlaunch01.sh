#!/bin/bash

#To install new packages on minion(xy)-ovh.minsys.cloud ONLY

# CHANGE : line 13
# CHANGE : line 23
# CHNAGE : line 33

#Q : lvi@minsys.io

ANSIBLE_CONF_DIR=/etc/ansible
ANSIBLE_INVENTORY_DIR=$ANSIBLE_CONF_DIR/inventory
ANSIBLE_PLAYBOOKS_DIR=$ANSIBLE_CONF_DIR/playbooks/tests
ANSIBLE_CONFGIT_DIR=/opt/ansible
ANSIBLE_CONFGIT_TRUNK_DIR=$ANSIBLE_CONFGIT_DIR/trunk
LAUNCHPAD_DIR=$ANSIBLE_CONFGIT_TRUNK_DIR/_launchpad 

echo "Local Repository upate"
cd $ANSIBLE_CONFGIT_DIR
svn update

echo "Copy Repository & last updated working configuration to Ansible Configuration Directory"
chmod u+x $LAUNCHPAD_DIR/testlaunch01.sh
cp -r $ANSIBLE_CONFGIT_TRUNK_DIR/* $ANSIBLE_CONF_DIR
:> /root/.ssh/known_hosts

echo "Ansible Inventory Initilization"
echo "File name format of the inventory : /etc/ansible/inventory/pods/FILENAME"
read -p 'Please enter the inventory FILENAME  : ' host_inventory
cp $host_inventory $ANSIBLE_INVENTORY_DIR/hosts

echo "Launching Ansible PLAYBOOK"
ansible-playbook $ANSIBLE_PLAYBOOKS_DIR/testlaunch01.yml
exit
