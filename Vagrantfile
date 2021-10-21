$copy_private_key_ansible = <<-SCRIPT
  cp /vagrant/ssh/key /home/vagrant && \
  chmod 600 /home/vagrant/key && 
  chown vagrant:vagrant /home/vagrant/key
SCRIPT

$install_ansible = <<-SCRIPT
  apt-get update && \
  apt-get install -y software-properties-common && \
  apt-add-repository --yes --update ppa:ansible/ansible && \
  apt-get -y install python3 ansible
SCRIPT

$exec_ansible = <<-SCRIPT
  ansible-galaxy collection install 'community.mysql:==1.1.1' && \
  ansible-playbook -i /vagrant/ansible/hosts \
  /vagrant/ansible/main.yml
SCRIPT

$copy_public_key_host = <<-SCRIPT
  cat /vagrant/ssh/key.pub >> .ssh/authorized_keys
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "azure"

  config.ssh.private_key_path = "ssh/key"

  config.vm.provider "azure" do |azure, override|
    azure.tenant_id = "57294900-c35e-4948-91fa-ebdf90d3427e"
    azure.client_id = "919dcf33-8183-4411-95b6-acb308e8c4d1"
    azure.client_secret = "R.WgQz..J2Z0Ta2ctJel0KSluSwBaA5cpY"
    azure.subscription_id = "3231ca8c-f392-4473-b23d-ef052e9eed0f"
    azure.vm_image_urn = "Canonical:UbuntuServer:18.04-LTS:latest"
    azure.location = "westus"
    azure.resource_group_name = 'vagrant'
  end

  config.vm.define "mysqlserver" do |mysqlserver|

    mysqlserver.vm.provider "azure" do |azure|
      azure.vm_name = "mysqlserver"
    end

    mysqlserver.vm.provision "shell", inline: $copy_public_key_host
  end

  config.vm.define "springapp" do |springapp|
    springapp.vm.network "forwarded_port", guest: 8080, host: 8080

    springapp.vm.provider "azure" do |azure|
      azure.vm_name = "springapp"
      azure.tcp_endpoints = "8080"
    end

    springapp.vm.provision "shell", inline: $copy_public_key_host
  end

  config.vm.define "ansible" do |ansible|
    ansible.vm.network "private_network", ip: "10.80.4.12"

    ansible.vm.provider "azure" do |azure|
      azure.vm_name = "ansiblemachine"
    end

    ansible.vm.provision "shell", inline: $copy_private_key_ansible
    ansible.vm.provision "shell", inline: $install_ansible
    ansible.vm.provision "shell", privileged: false, inline: $exec_ansible
  end
end