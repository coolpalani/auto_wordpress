#!/bin/bash
#Instalation of packages:
sudo apt update && sudo apt install virtualenv
mkdir openstack && virtualenv ./openstack/auto_wordpress
source ./openstack/auto_wordpress/bin/activate
pip install python-openstackclient ansible python-heatclient

#parameters you can change: flavor, key_name, image, net
openstack stack create -t ./heat/servers.yml stack --parameter "flavor=m1.mini" --parameter "image=Debian Stretch 9.1" --parameter "key_name=cloud" --parameter "net=red de manuel.franco"

flag=1
while [[ $flag == 1 ]]; do
	IP=$(openstack server list | grep server1 | cut -d ',' -f 2 | cut -d '|' -f 1)
	if [ -z "$IP" ]; then
		flag=1
	else
		echo $IP
		flag=0
	fi
done
flag=1
while [[ $flag == 1 ]]; do
	IP2=$(openstack server list | grep server2 | cut -d ',' -f 2 | cut -d '|' -f 1)
	if [ -z "$IP2" ]; then
		flag=1
	else
		echo $IP2
		flag=0
	fi
done
echo [server1] > ./ansible/hosts.ini
echo $IP >> ./ansible/hosts.ini
echo [server2] >> ./ansible/hosts.ini
echo $IP2 >> ./ansible/hosts.ini
echo server1_ip: $IP >> ./ansible/group_vars/all
echo server2_ip: $IP2 >> ./ansible/group_vars/all
cd ansible
flag=1
while [[ $flag == 1 ]]; do
	ansible server1 -m ping
	if [[ $? == 0 ]];then
		flag=0
	fi
done
ansible-playbook playbook.yml
deactivate
rm -rf  ../openstack
