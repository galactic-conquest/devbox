# Install Devbox for Windows

### 1. Software
1\. Install VirtualBox
```
VirtualBox 
v5.2.8 or greater with guest additions 
(open virtualbox after install and you will be asked to install guest additions as well) 
https://www.virtualbox.org/wiki/Downloads
```
2\. Install Vagrant
```
Vagrant
v2.0.3 or greater 
https://www.vagrantup.com/downloads.html
```

### 2. Plugins
1\. Open cmd in administrator mode and CD to the root directory where the "Vagrantfile" is.
2\. Execute following commands one by one.
```
vagrant plugin install vagrant-bindfs
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-winnfsd
```

### 3. Hosts
1\. Open Windows hosts file.
```
Windows: C:\Windows\System32\drivers\etc\hosts
```
2\. Append this.
```
192.168.98.100 dev.galactic-conquest.com
192.168.98.100 dev.phpmyadmin.com
```

### 4. Git Clone
1\. Clone/Download both projects to your workspace directory.\
**2\. Now, your current directory structure should looks like this and is necessary.**
```
| workspace
|--dev.galactic-conquest.com (https://github.com/galactic-conquest/galactic-conquest)
|--devbox (https://github.com/galactic-conquest/devbox)
|---Vagrantfile
```

### 5. Start Vagrant
1\. Open cmd in administrator mode and CD to the root dir where the "Vagrantfile" is.\
2\. Execute command which creates the virtual machine. This can take a while at the first run.
```
vagrant up
```

3\. Login to virtual machine and opens a shell.
```
vagrant ssh
```
4\. CD to project directory.
```
cd /var/www/dev.galactic-conquest.com

```
5\. From here you can execute project specific commands. Get a list of possible commands.
```
vendor/bin/inferno list
```

### 6. Additional
Further vagrant commands (execution in main directory). 
```
vagrant ssh // Login to the virtual machine and open a shell.
vagrant halt // stops vagrant machine
vagrant up // starts vagrant machine (provisioning will start only once)
```

Database credentials:
```
dev.phpmyadmin.com
username: dev
password: dev
```
