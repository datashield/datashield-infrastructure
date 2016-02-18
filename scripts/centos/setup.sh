#!/usr/bin/env bash

# Installs puppet, git and r10k on a Centos machine.

PUPPET_DIR="/opt/puppetlabs"
PUPPET_BIN="$PUPPET_DIR/puppet/bin"

DISTRIB_RELEASE=`rpm -qa 'centos*release*' --queryformat '%{VERSION}'`

echo "Running Puppet setup script for Centos"
echo "Centos Enterprise version: $DISTRIB_RELEASE"

# Install Puppet
if [ ! -d "$PUPPET_DIR" ]; then
    echo "Installing Puppet"
    sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-${DISTRIB_RELEASE}.noarch.rpm
    sudo yum update -y
    sudo yum install puppet-agent -y
fi
# Install GIT
sudo yum install git -y
# Install r10k
echo "Checking / Installing r10k"
${PUPPET_BIN}/gem query --name r10k --installed &> /dev/null || sudo ${PUPPET_BIN}/gem install r10k

if [ ! -e "$PUPPET_DIR/bin/r10k" ]; then
    ln -s ${PUPPET_BIN}/r10k ${PUPPET_DIR}/bin/r10k
fi