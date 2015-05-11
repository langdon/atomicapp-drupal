Vagrant.configure(2) do |config|
  config.vm.box = "rhel-atomic-7.1"
  config.vm.define :containerapp_drupal do | host |
    host.vm.hostname = "containerapp-drupal"
    host.vm.synced_folder ".", "/vagrant", disabled: true
#    host.vm.synced_folder ".", "/mnt/vagrant", type: "rsync",
#                          rsync__exclude: [ ".git/", ".#*", "*~" ]
    host.vm.provision 'shell', inline: "sudo mkdir /mnt/host-projects/ > /dev/null 2>&1 || :" #in case this isn't first run
    host.vm.provision 'shell', inline: "sudo mount.nfs -v 192.168.100.1:/mnt/nbu/loc-projects /mnt/host-projects/"
    host.vm.provision 'shell', inline: "ln -fs /mnt/host-projects/cdk-work/container-tools/atomicapp-drupal ~/"
    host.vm.provision 'shell', inline: "ln -fs /mnt/host-projects/cdk-work/container-tools ~/"

    host.vm.provision 'shell', inline: "sudo systemctl stop docker > /dev/null 2>&1 || :" #in case this isn't first run
    host.vm.provision 'shell', inline: "sudo groupadd docker > /dev/null 2>&1 || :"
    host.vm.provision 'shell', inline: "sudo usermod -a -G docker vagrant"
    host.vm.provision 'shell', inline: "sudo systemctl enable docker && sudo systemctl start docker"
    host.vm.provision 'shell', inline: "sudo chown root:docker /var/run/docker.sock"

  end
end
