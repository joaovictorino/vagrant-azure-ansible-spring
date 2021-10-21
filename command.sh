vagrant plugin install vagrant-azure

vagrant box add azure https://github.com/azure/vagrant-azure/raw/v2.0/dummy.box --provider azure

az ad sp create-for-rbac

#Workaround
vagrant up mysqlserver --provision
vagrant up springapp --provision
vagrant up ansible --provision

Open port 80 on VM -> networking