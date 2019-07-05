Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/disco64"
    config.vm.network "forwarded_port", guest: 80, host: 1234
    config.vm.network "private_network", ip: "192.168.98.100"
    config.vm.provision :shell, :path => ".vagrant/provision/bootstrap.sh"

    config.vm.synced_folder "./../", "/var/www", type: "nfs", create: true, fsnotify: true
    config.winnfsd.uid = 33
    config.winnfsd.gid = 33

    config.vm.provision :shell, :inline => "sudo service redis restart", run: "always"
    config.vm.provision :shell, :inline => "sudo service php7.3-fpm restart", run: "always"
    config.vm.provision :shell, :inline => "sudo service nginx restart", run: "always"
    config.vm.provision :shell, :inline => "sudo service mysql restart", run: "always"

#    config.trigger.after :up do |trigger|
#      trigger.info = "Running fsnotify"
#      trigger.run = {inline: "vagrant fsnotify"}
#    end

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    end
end