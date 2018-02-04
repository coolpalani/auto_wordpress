# auto_wordpress
Wordpress automatic deployment with openstack heat and ansible.

Is necesary hace already install sudo.

For the execution of deploy.sh you need activate openstack's credentials and change the ssh key on ansible.cfg.

Then, you have to modify the script with your own Openstack's parameters:
~~~
openstack stack create -t ./heat/servers.yml stack --parameters "key_name=your_key" "net=your_private_net"
~~~
Also you can personalize wordpress with group_vars/all file where are all variables of wordpress configuration.
