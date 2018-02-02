#!/bin/bash
#Parametros a cambiar flavor, key_name, image, net
#Crear stack en openstack mediante heat
#Si quiere cambiar parametros, por tener claves diferentes o diferente red:
#openstack stack create -t ./heat/servers.yml stack --parameters "key_name=tu_key" "net=tu_red_interna"
openstack stack create -t ./heat/servers.yml stack

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
echo " " > ./ansible/hosts.ini
echo [server1] >> ./ansible/hosts.ini
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
