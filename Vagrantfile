Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/disco64"
    config.vm.box_check_update = false
    config.vm.network "forwarded_port", guest: 80, host: 1234
    config.vm.network "private_network", ip: "192.168.98.100", nic_type: "virtio"
    config.vm.provision :shell, :path => ".vagrant/provision/bootstrap.sh"

    config.vm.synced_folder "./../", "/var/www", type: "nfs", mount_options: ['rw', 'vers=3', 'tcp', 'fsc' ,'actimeo=1'], create: true, fsnotify: true, exclude: ["*.php", "*.ini", "*.git", "*.idea", "devbox", "node_modules", "public", "vendor", "data"]

    config.winnfsd.uid = 33
    config.winnfsd.gid = 33

    config.vagrant.plugins = ["vagrant-bindfs", "vagrant-vbguest", "vagrant-winnfsd", "vagrant-fsnotify", "vagrant-share"]

    config.vm.provision :shell, :inline => "sudo service redis restart", run: "always"
    config.vm.provision :shell, :inline => "sudo service php7.3-fpm restart", run: "always"
    config.vm.provision :shell, :inline => "sudo service nginx restart", run: "always"
    config.vm.provision :shell, :inline => "sudo service mysql restart", run: "always"

    config.trigger.after :up do |trigger|
      trigger.name = "fsnotify"
      trigger.info = "Running fsnotify"
      trigger.run = {inline: "vagrant fsnotify"}
    end

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--chipset", "ich9" ]
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        vb.customize ["modifyvm", :id, "--nictype1", "virtio" ]
        vb.customize ["modifyvm", :id, "--nictype2", "virtio" ]
    end
end