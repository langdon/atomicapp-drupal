Vagrant.configure(2) do |config|
#https://github.com/LalatenduMohanty/centos7-container-app-vagrant-box
  config.vm.box = "atomicapp/dev"
  config.vm.define :atomicapp_drupal do | host |
    host.vm.hostname = "containerapp-drupal"
    host.vm.synced_folder ".", "/vagrant", disabled: true
#    host.vm.synced_folder ".", "/mnt/vagrant", type: "rsync",
#                          rsync__exclude: [ ".git/", ".#*", "*~" ]
    host.vm.provision 'shell', inline: "sudo yum -y update" #in case this isn't first run
    host.vm.provision 'shell', inline: "sudo yum -y install nfs-utils libyaml-devel PyYAML tree" #in case this isn't first run
    host.vm.provision 'shell', inline: "sudo mkdir /mnt/host-projects/ > /dev/null 2>&1 || :" #in case this isn't first run
    host.vm.provision 'shell', inline: "sudo umount /mnt/host-projects/ > /dev/null 2>&1 || : && sudo mount.nfs -v 192.168.100.1:/mnt/nbu/loc-projects /mnt/host-projects/"
    host.vm.provision 'shell', inline: "ln -fs /mnt/host-projects/cdk-work/container-tools/atomicapp-drupal /home/vagrant/"
    host.vm.provision 'shell', inline: "ln -fs /mnt/host-projects/cdk-work/container-tools/atomicapp /home/vagrant/"
    host.vm.provision 'shell', inline: "ln -fs /mnt/host-projects/cdk-work/container-tools /home/vagrant/"
    host.vm.provision 'shell', inline: "cd /home/vagrant/atomicapp && sudo python setup.py install"

#    host.vm.provision 'shell', inline: "sudo systemctl stop docker > /dev/null 2>&1 || :" #in case this isn't first run
#    host.vm.provision 'shell', inline: "sudo groupadd docker > /dev/null 2>&1 || :"
#    host.vm.provision 'shell', inline: "sudo usermod -a -G docker vagrant"
#    host.vm.provision 'shell', inline: "sudo systemctl enable docker && sudo systemctl start docker"
#    host.vm.provision 'shell', inline: "sudo chown root:docker /var/run/docker.sock"

  end
end
