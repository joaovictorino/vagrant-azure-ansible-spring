vagrant plugin install vagrant-azure

vagrant box add azure https://github.com/azure/vagrant-azure/raw/v2.0/dummy.box --provider azure

az ad sp create-for-rbac

#Workaround
vagrant up mysqlserver
vagrant up springapp
vagrant up ansible

Open port 80 on VM -> networking