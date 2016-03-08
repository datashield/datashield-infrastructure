# datashield-infrastructure

#### Table of Contents

1. [Description](#description)
1. [Usage - How to use this module to install datashield](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Infrastructure set up code, examples and puppet environments for datashield. This repo consists in three parts. Under 
`vagrant` are vagrant set up files for creating different types of datashield VMs. Under `scripts` are shell scripts 
which install the necessary software (puppet, git, r10K) needed to provision a VM using puppet. Under `puppet` are 
several puppet environment examples for provisioning different types of machines. 

## Usage

### Create datashield VMs with Vagrant

To create Virtual machines (VMs) using the Vagrantfiles in this repo you first need to have Vagrant installed on your 
system. Go to https://www.vagrantup.com/downloads.html and download and install the correct version of vagrant for your
operating system. If you are creating local VMs you will also need to install VirtualBox as this is what is being used 
to create the virtual machines, see https://www.virtualbox.org/wiki/Downloads for the correct VirtualBox download. 

If you are using local VMs with VirtualBox a useful Vagrant plugin to install is `vagrant-cachier`. This plugin caches 
the downloaded packages etc. for faster provisioning. To install the plugin, once vagrant has been installed use the 
command:

```bash
vagrant plugin install vagrant-cachier
```

After you have install Vagrant and VirtualBox getting a VM with datashield up and running is as easily as two commands, 
for example to create a datashield server with test data using a Ubuntu system (assuming you are in the root directory 
of this repo) you would run:

```bash
cd vagrant/datashield_testdata_ubuntu/
vagrant up
```

similarly to spin up a client VM with Centos as the base system you could run the following commands:

```bash
cd vagrant/datashield_client_centos/
vagrant up
```

to ssh into a VM that you have created you can use the `vagrant ssh` command from the directory of the Vagrantfile. 
Once you are finished with a machine you can remove it by issuing the `vagrant destroy` command, also from the same 
directory. If your vagrant setup has two machines, i.e. a client and server or database server and a datashield server 
you can ssh into the machines using `vagrant ssh machine_name` e.g. `vagrant ssh db_server`. 

Note: Sometimes windows have problems with the Vagrant networks. This seems to be a Virtual box bug, one possible way 
around the problem is to change the network IP address from 192.168.2.x to 192.168.56.x. by change the line if the 
Vagrantfile like the example below:

```ruby
- config.vm.network "private_network", ip: "192.168.2.6"
+ config.vm.network "private_network", ip: "192.168.56.6"
```

#### Create VMs on Google Compute Engine

Datashield VMs can also be created on the Google Compute Engine using Vagrant. Once the machines have been created you 
might decide to save a snapshot of the machine so it can be provisioned quickly in the future. To create VMs on Google
Compute Engine you must have an account setup, a 2 month trial account is available. To use Vagrant with Google Compute 
Engine you also need to install a Vagrant plugin:

```bash
vagrant plugin install vagrant-google
```

To enable provisioning of cloud VMs on Google Compute Engine first move the file `vagrant/.vagrant.d/Vagrantfile` to 
your Vagrant home directory, normally `${HOME}/.vagrant.d`. Then open the file to edit. There are a few configuration 
sections that need to be filled in, for example `google_project_id` etc. To get the information for the file follow the
instructions below for each section:

* **_google_project_id_**: This is the ID of your Google Compute Engine project. Login to the Google Cloud console at 
https://console.cloud.google.com/home/ making sure that the correct project is selected from the top right (or create 
a new project). The project ID is then given on the dashboard home screen under the project name with the label project 
id.

* **_google_client_email_** and **_google_json_key_location_**: Log in to the permissions section of the Google Cloud console at 
https://console.cloud.google.com/permissions. Click on service accounts and then create new service account. Select a 
name for the account and make sure you click *Furnish a new private key* and leave select JSON for file type. Click on 
create and a file will be downloaded. Your *google_client_email* is then the email address for the service account, i.e. 
the address ending `@ ... gserviceaccount.com`. Move the JSON file that was downloaded somewhere sensible on your computer 
then add the client email and the location of the download JSON file to your Vagrantfile. 

* **_ssh.username_** and **_ssh.private_key_path_**: To SSH into the machines once you have provisioned them you need to
copy your ssh key to the meta data section on the Google Compute Cloud. You may already have an ssh key in your `.ssh` 
folder. I.e. `ls $HOME/.ssh/id_rsa`. If one already exists you should not need to create another key. If you don't have 
a key, create one using the command, `ssh-keygen -t rsa -b 4096`. You then need to copy your key to the clip board. Using 
a Mac this can be done with the command `pbcopy < ~/.ssh/id_rsa.pub` or on Linux this can be done with the xclip command, 
i.e. `xclip -sel clip < ~/.ssh/id_rsa.pub`. To add the key go to the Metadata section of the Compute engine section of 
the Google Cloud Console. I.e. https://console.cloud.google.com/compute/metadata. Once there click on the ssh keys tab. 
Click on edit and copy the whole key into a new entry in the space provided, then click save. Your username will appear
next to the key that you have entered, this is the username to add to the *ssh.username* section. If you have saved your
key in the default location you will not have to edit the *ssh.private_key_path*. 

After the file above is setup correctly you can go to any vagrant directory of this cloned repo ending with *_google* and type:
 
```bash
vagrant up --provider=google
```

to start a VM as you would to create a local VM.

Note about networks: 

By default Google Compute Engine blocks all external ports to a VM and so you will not be able to 
access Opal or rstudio. You will need to open the correct ports on the *default* network to get these services to work 
from the outside world. A better way though might be to setup different networks (under the networking tab in Google cloud console) which you can then apply in different 
situations. For Example:

* **server-internal**: This network should have no additional firewall rules other than the default setup by Google. This
would allow access to the server from the Google Compute Network but not from the outside world. E.g. when using a client
machine as an access point.

* **server-external**: For when the server needs external access. You will need to add a firewall rule to open the ports
required by Opal, i.e. tcp:8080 and / or tcp:8443. 

* **client-external**: For when you are accessing a client machine from the outside world. This would need firewall ports
opening for Agate (tcp:8081 and / or tcp:8444) and RStudio (tcp:8787) if they were being installed on the client machine.

To check that the VMs have been provisioned correctly go to the *compute engine* in Google cloud console. 

### Use puppet to provision your own VM or physical server

You can use the puppet environments in this repo to provision machines, both physical and virutal, that have already 
been created (assuming these machines are using Ubuntu or Centos operating systems). If your computer infrastructure 
is already using puppet enterprise it is possible you already have a puppet master. If this is the same then the 
puppet environments and modules can be installed on the puppet master and that can be used to install datashield 
on your machine.

If you are not already running puppet enterprise to be able to use the puppet code, puppet, r10k and git will need 
to be installed. The script in `scripts/[OS]/setup.sh` is design to install these programs for you. You can get a copy
of the correct script by running the following commands (where [OS] is replaced by 
centos or ubuntu):

```bash
curl -OL http://raw.githubusercontent.com/datashield/datashield-infrastructure/master/scripts/[OS]/setup.sh
chmod +x setup.sh
```

to install puppet, git and r10k you can then run:

```bash
./setup.sh
```

Once this command has been run you can checkout this repo to get a copy of the puppet environments. I.e.

```bash

git clone https://github.com/datashield/datashield-infrastructure.git
```

then for the environment you would like to use move to that directory (for this example we assume a 
datashield-infrastructure directory installed at the root directory /). Once you have moved to that directory use r10k
to download the puppet modules that will be needed by the environment (in this case `datashield_testdata`). For example:

```bash
cd /datashield-infrastructure/puppet/environments/datashield_testdata/
r10k puppetfile install
```

(If the r10k binary can not been found in your path, the full path is `/opt/puppetlabs/puppet/bin/r10k`. Similarly if 
puppet can not be found the full path to the binary is `/opt/puppetlabs/bin/puppet`. Replace r10k and puppet with the
full absolute paths if needed.) 

The `site.pp` file inside the manifests directory can be edited if the environment requirement is not exactly suited to 
the example. *The file should also be editted to change the passwords for the database servers and opal admin from 
their default values especially if sensitive data is involved!*. Documentation on the variables for editing the 
datashield puppet options can be found by reading the README file associated with the puppet-datashield repo. The 
puppet environment can then be applied with the commands:

```bash
cd /datashield-infrastructure/puppet/environments/datashield_testdata/manifests/
sudo puppet apply site.pp --environment datashield_testdata --environmentpath /datashield-infrastructure/puppet/environments
```

You might decide to copy or link the datashield environment to puppets default environment path. For example:

```bash
sudo ln -s /datashield-infrastructure/puppet/environments/datashield_testdata /etc/puppetlabs/code/environments/datashield_testdata
```

The commands for provisioning the machine is then: 

```bash
cd /etc/puppetlabs/code/environments/datashield_testdata/manifests/
sudo puppet apply site.pp --environment datashield_testdata
```

If you are running an older version of puppet (for example puppet 3.x) you will not have environments. Hence replace 
environmentpath with modulepath in your puppet apply commands. For example:

```bash
cd /datashield-infrastructure/puppet/environments/datashield_testdata/manifests/
sudo puppet apply site.pp --modulepath /datashield-infrastructure/puppet/environments/datashield_testdata/modules
```

## Reference

### Puppet environment examples

The puppet enviroments are under the directory `puppet/environments` in this repo. In each environment directory there 
is a `Puppetfile` which contains a list of the required puppet modules for each environment and is used to install the 
needed modules, and a `manifests/site.pp` file which provisions the machine. The `.gitirgnore` file is used so that the 
modules directory installed by r10k is not included in this git repo. The four puppet modules written for the environments 
can be found in their own git repos with the prefix *puppet-*.

##### datashield_client

This puppet environment will provision the datashield client software, i.e. the client R packages and rstudio on a 
Ubuntu or Centos machine. This environment will also install Agate for user management and a MongoDB database which is 
required to hold Agate data.

##### datashield_nodata

This puppet environment will provision the datashield server software on a Ubuntu or Centos machine. By default both an
MySQL and MongoDB database server will be installed on the machine and the machine will have a firewall activated. The
datashield test data will not be installed using this environment.

##### datashield_testdata

This puppet environment will provision the datashield server software on a Ubuntu or Centos machine. By default both an
MySQL and MongoDB database server will be installed on the machine and the machine will have a firewall activated. The
datashield test data and projects will also be installed using this environment.

##### datashield_testdata_development

As above but will install the development version of Opal and the development branch of the server side R packages. 
* Note: You will need to edit this environment once you know what the development branch names are going to be *

##### datashield_travis

This is the puppet environment used for testing datashield modules using travis continuous integration. This puppet 
environment will provision the datashield server software on a Ubuntu or Centos machine (although travis usese Ubuntu). 
By default both an MySQL and MongoDB database server will be installed on the machine but for compatiblity with travis 
the firewall will not be installed. The datashield test data and projects will also be installed using this environment
for running the datashield package tests against.

##### datashield_db_server

This is a puppet environment used to install the database servers, i.e. MySQL and MongoDB but not Opal or datashield. This 
may be useful if you would like your database servers and hence data on a different machine or VM from Opal and datasheild.

##### datashield_remotedb

This is a puppet environment to show how a datashield install could be setup to connect to a remote database server, that 
is a database server provisioned with `datashield_db_server` or a database server setup in another way. This environment 
therefore does not install MySQL or MongoDB on this machine but installs Opal and datashield, along with the filewall and
registers the remote database servers with the Opal install.

### Vagrant VM examples

These Vagrantfile examples can be used to create datashield VMs and sets of VMs. The VMs are create with virtual box and
using google cloud compute engine. The .gitignore file is included to the .vagrant directory create when the VMs 
are create is not included in this repo.

##### datashield_client_centos

This Vagrantfile will create a datashield client machine using the datashield_client puppet environment built on top
of a Centos vagrant box. By default the VM has 1GB of RAM and the private IP address of the machine is 192.168.2.10.

##### datashield_client_centos_google

This Vagrantfile will create a datashield client machine on Centos but on the Google Cloud Compute Engine.

##### datashield_client_ubuntu

This Vagrantfile will create a datashield client machine using the datashield_client puppet environment built on top
of a Ubuntu vagrant box. By default the VM has 1GB of RAM and the private IP address of the machine is 192.168.2.11.

##### datashield_client_ubuntu_google

This Vagrantfile will create a datashield client machine on Ubuntu but on the Google Cloud Compute Engine.

##### datashield_testdata_centos

This Vagrantfile will create a datashield server machine using the datashield_testdata puppet environment built on 
top of a Centos vagrant box. By default the VM has 2GB of RAM and the private IP address of the machine is 192.168.2.5.

##### datashield_testdata_centos_google

This Vagrantfile will create a datashield server machine on Centos but on the Google Cloud Compute Engine.

##### datashield_testdata_ubuntu

This Vagrantfile will create a datashield server machine using the datashield_testdata puppet environment built on 
top of a Ubuntu vagrant box. By default the VM has 2GB of RAM and the private IP address of the machine is 192.168.2.6.

##### datashield_testdata_ubuntu_development

As above but installing the development version of Opal and server side packages.

##### datashield_testdata_ubuntu_google

This Vagrantfile will create a datashield server machine on Ubuntu but on the Google Cloud Compute Engine.

##### datashield_testdata_ubuntu_development_google

As above but installing the development version of Opal and server side packages

##### datashield_db_server_ubuntu

This Vagrantfile will create a datashield db server machine using the datashield_db_server puppet environment built on 
top of a Ubuntu vagrant box. By default the VM has 1GB of RAM and the private IP address of the machine is 192.168.2.20.

##### datashield_remote_db_centos

This Vagrant configuration file is for a configuring two Centos VMs. The first VM is a database server with the IP address
192.168.2.21 provisioned using the datashield_db_server environment. The second is a datashield server with the IP
address 192.168.2.22 provisioned with the datashield_remotedb environment.

##### datashield_3servers_1client

This Vagrant configures three Ubuntu datashield servers provisioned with datashield_testdata puppet environment with the
IP addresses 192.168.2.32, 192.168.2.33 and 192.168.2.34. Also created is a datashield client provisioned with the 
datashield_client puppet environment.

##### datashield_3servers_1client_google

This Vagrantfile creates 3 datashield servers and 1 datashield client on Google Cloud Compute Engine.


### Scripts

##### setup.sh

There is a setup.sh script for both Centos and Ubuntu, in respective directories. These scripts install the software
needed for puppet to run and for the puppet modules to be downloaded. I.e. they install puppet, git (as some modules
come from github and not the puppet forge) and r10k which is used to manage the puppet module requirements for the 
different environments. 

## Limitations

Has only been tested using Ubuntu 14.04 and Centos 7 machines. 

## Development

Open source, forks and pull requests welcomed. 

