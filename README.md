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
directory.

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
curl -OL http://raw.githubusercontent.com/nparley/datashield-infrastructure/master/scripts/[OS]/setup.sh
chmod +x setup.sh
```

to install puppet, git and r10k you can then run:

```bash
./setup.sh
```

Once this command has been run you can checkout this repo to get a copy of the puppet environments. I.e.

```bash

git clone https://github.com/nparley/datashield-infrastructure.git
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

The puppet environment can then be applied with the commands:

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

## Reference

### Puppet environment examples

The puppet enviroments are under the directory `puppet/environments` in this repo. In each environment directory there 
is a `Puppetfile` which is used to install the needed puppet modules, and a `manifests/site.pp` file which provisions 
the machine. The `.gitirgnore` file is used so that the modules directory installed by r10k is not included in this git 
repo. The four puppet modules written for the environments can be found in their own git repos with the prefix *puppet-*.

##### datashield_client

This puppet environment will provision the datashield client software, i.e. the client R packages and rstudio on a 
Ubuntu or Centos machine. 

##### datashield_nodata

This puppet environment will provision the datashield server software on a Ubuntu or Centos machine. By default both an
MySQL and MongoDB database server will be installed on the machine and the machine will have a firewall activated. The
datashield test data will not be installed using this environment.

##### datashield_testdata

This puppet environment will provision the datashield server software on a Ubuntu or Centos machine. By default both an
MySQL and MongoDB database server will be installed on the machine and the machine will have a firewall activated. The
datashield test data and projects will also be installed using this environment.

##### datashield_travis

This is the puppet environment used for testing datashield modules using travis continuous integration. This puppet 
environment will provision the datashield server software on a Ubuntu or Centos machine (although travis usese Ubuntu). 
By default both an MySQL and MongoDB database server will be installed on the machine but for compatiblity with travis 
the firewall will not be installed. The datashield test data and projects will also be installed using this environment
for running the datashield package tests against.

### Vagrant VM examples

These Vagrantfile examples can be used to create datashield VMs and sets of VMs. The VMs are create with virtual box and
using google cloud compute engine. The .gitignore file is included to the .vagrant directory create when the VMs 
are create is not included in this repo.

##### datashield_client_centos

This Vagrantfile will create a datashield client machine using the datashield_client puppet environment built on top
of a Centos vagrant box. By default the VM has 1GB of RAM and the private IP address of the machine is 192.168.2.10.

##### datashield_client_ubuntu

This Vagrantfile will create a datashield client machine using the datashield_client puppet environment built on top
of a Ubuntu vagrant box. By default the VM has 1GB of RAM and the private IP address of the machine is 192.168.2.11.

##### datashield_testdata_centos

This Vagrantfile will create a datashield server machine using the datashield_testdata puppet environment built on 
top of a Centos vagrant box. By default the VM has 2GB of RAM and the private IP address of the machine is 192.168.2.5.

##### datashield_testdata_ubuntu

This Vagrantfile will create a datashield server machine using the datashield_testdata puppet environment built on 
top of a Ubuntu vagrant box. By default the VM has 2GB of RAM and the private IP address of the machine is 192.168.2.6.

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
