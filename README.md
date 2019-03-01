# Install
### 1. Software
```
VirtualBox 
v5.2.8 or higher with guest additions 
(open virtualbox after install and you will be asked to install guest additions as well) 
https://www.virtualbox.org/wiki/Downloads

Vagrant
v2.0.3 or higher 
https://www.vagrantup.com/downloads.html
```

### 2. Plugins
1. Open shell/cmd and CD to the root dir where the "Vagrantfile" is.
2. Execute following commands one by one.

```
vagrant plugin install vagrant-bindfs
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-winnfsd
```

### 3. Git Clone

1. Clone both projects to your workspace.
2. Directory name of dev.galactic-conquest.com is necessary.
3. Your current directory structure looks like the following.
```
| workspace
|--dev.galactic-conquest.com (https://github.com/galactic-conquest/galactic-conquest)
|--vagrant (https://github.com/galactic-conquest/vagrant)
|---Vagrantfile
```


### 3. Hosts
1. Open hosts file of your OS.
Windows: C:\Windows\System32\drivers\etc\hosts
Other OS: /etc/hosts

2. Append this to your hosts file.

```
192.168.98.100 dev.galactic-conquest.com
192.168.98.100 dev.phpmyadmin.com
```

### 4. Start Vagrant
1. Open shell/cmd and CD to the root dir where the "Vagrantfile" is.
2. Execute command.

```
vagrant up
```

4. Wait until provisioning is completed.

### 6. Additional
Further vagrant commands.
```
vagrant ssh // Login to the vagrant machine 
vagrant halt // stop vagrant machine
vagrant up // start vagrant machine (provisioning will start only once)
```

Database credentials for dev.phpmyadmin.com
username: dev
password: dev


