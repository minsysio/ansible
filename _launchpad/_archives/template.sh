#!/bin/bash

#Q : lvi@minsys.io

#Misc
KNOWN_HOSTS=/root/.ssh/known_hosts

#Ansible directory : /etc/ansible 
ANSIBLE_CONF_DIR=/etc/ansible
ANSIBLE_INVENTORY_DIR=$ANSIBLE_CONF_DIR/inventory
ANSIBLE_PODS_DIR=$ANSIBLE_INVENTORY_DIR/pods
ANSIBLE_PLAYBOOKS_DIR=$ANSIBLE_CONF_DIR/playbooks

#Local SVN repository of Ansible : /opt/ansible 
ANSIBLE_CONFSVN_DIR=/opt/ansible
ANSIBLE_CONFSVN_TRUNK_DIR=$ANSIBLE_CONFSVN_DIR/trunk
LAUNCHPAD_DIR=$ANSIBLE_CONFSVN_TRUNK_DIR/_launchpad 

echo "**** INITIALIZATION ****"
# /root/.ssh/known_hosts exists and is not empty, then zero it. 
if [ -s "$KNOWN_HOSTS" ]; then
	echo "**** Zeroing ${KNOWN_HOSTS} file ****"
	:>"${KNOWN_HOSTS}"
	echo "**** ${KNOWN_HOSTS} file Zeroed  ****"
  else
  	echo "**** ${KNOWN_HOSTS} file already Zeroed ****"
fi

if [ -d "$ANSIBLE_CONFSVN_DIR" ]; then
	echo "**** Local Ansible SVN Repository update : ${ANSIBLE_CONFSVN_DIR} ****"
	cd $ANSIBLE_CONFSVN_DIR
	svn update 
   else
  	echo "**** ERROR : ${ANSIBLE_CONFSVN_DIR} doesn't exists ****"	
  	exit 
fi

if [ -d "$ANSIBLE_CONFSVN_TRUNK_DIR" ]; then
	echo "**** Copy repository & last updated configuration to Ansible Directory ****"
	cp -r $ANSIBLE_CONFSVN_TRUNK_DIR/* $ANSIBLE_CONF_DIR
	echo "**** DONE ****"
   else
  	echo "**** ERROR : ${ANSIBLE_CONFSVN_TRUNK_DIR} doesn't exists ****"	
  	exit 	
fi

if [ -d "$ANSIBLE_INVENTORY_DIR" ]; then
	echo "**** Ansible Inventory Initilization ****"
	echo "**** PODS available : ****"
	ls $ANSIBLE_PODS_DIR
	read -p 'Please enter the pod FILENAME in the scope of this playbook : ' pod_inventory
	#Add a structure de controle ... 
	echo "**** Inventory - hosts - file : ****"
	cp $ANSIBLE_PODS_DIR/$pod_inventory $ANSIBLE_INVENTORY_DIR/hosts
	cat $ANSIBLE_INVENTORY_DIR/hosts
   else
  	echo "**** ERROR : ${ANSIBLE_INVENTORY_DIR} doesn't exists ****"	
  	exit 	
fi


if [ -d "$ANSIBLE_PLAYBOOKS_DIR" ]; then
	echo "**** Ansible PLAYBOOK Launch ****"
	echo "**** PLAYBOOKS available : ****"
	ls $ANSIBLE_PLAYBOOKS_DIR
	read -p 'Please enter the playbook FILENAME to launch : ' launch_playbook
	#Add a structure de controle ... 
	echo "**** Launching Ansible PLAYBOOK ****"
	echo "**** ansible-playbook ${ANSIBLE_PLAYBOOKS_DIR}/${launch_playbook} ****"
	#ansible-playbook $ANSIBLE_PLAYBOOKS_DIR/testlaunch01.yml
   else
  	echo "**** ERROR : ${ANSIBLE_PLAYBOOKS_DIR} doesn't exists ****"	
  	exit 	
fi
exit
