# Install Devbox for Windows

### 1. Software
1\. Install VirtualBox
```
VirtualBox 
v6.0.8 or greater with guest additions 
(open virtualbox after install and you will be asked to install guest additions as well.) 
https://www.virtualbox.org/wiki/Downloads
```
2\. Install Vagrant
```
Vagrant
2.2.5 or greater 
https://www.vagrantup.com/downloads.html
```

### 2. Plugins
1\. Open cmd in administrator mode and CD to the root directory where the "Vagrantfile" is.\
2\. Execute following commands one by one.
```
vagrant plugin install vagrant-bindfs
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-winnfsd
vagrant plugin install vagrant-fsnotify
```

### 3. Hosts
1\. Open Windows hosts file.
```
Windows: C:\Windows\System32\drivers\etc\hosts
```
2\. Append this.
```
192.168.98.100 dev.galactic-conquest.net
192.168.98.100 dev.phpmyadmin.net
```

### 4. Git Clone
1\. Clone/Download both projects to your workspace directory.\
**2\. Your current directory structure should looks like this and is necessary.**
```
| workspace
|--dev.galactic-conquest.net (https://github.com/galactic-conquest/galactic-conquest)
|--devbox (https://github.net/galactic-conquest/devbox)
|---Vagrantfile
```

### 5. Start Vagrant
1\. Open cmd in administrator mode windows and CD to the root dir where the "Vagrantfile" is.\
2\. Execute command which creates the virtual machine. This can take a while at the first run.
```
vagrant up
```

3\. Login to virtual machine and open a shell.
```
vagrant ssh
```

### 6. Additional
Further vagrant commands (windows). 
```
vagrant ssh // Login to the virtual machine and opens a unix shell.
vagrant halt // stops vagrant machine
vagrant up // starts vagrant machine (provisioning will start only once)
```

Database
```
http://dev.phpmyadmin.net

username: dev
password: dev
```
