#!/usr/bin/env bash

# Installs puppet, git and r10k on a Ubuntu machine.

PUPPET_DIR="/opt/puppetlabs"
PUPPET_BIN="$PUPPET_DIR/puppet/bin"

DISTRIB_CODENAME=`lsb_release -sc`

echo "Running Puppet setup script for Ubuntu"
echo "Ubuntu codename: $DISTRIB_CODENAME"

sudo apt-get update -y -q
sudo apt-get install language-pack-en-base language-pack-en -y -q
sudo update-locale LANG="en_GB.UTF-8"

# Install Puppet
if [ ! -d "$PUPPET_DIR" ]; then
    echo "Installing Puppet"
    wget -nv https://apt.puppetlabs.com/puppet7-release-${DISTRIB_CODENAME}.deb
    sudo dpkg -i puppet7-release-${DISTRIB_CODENAME}.deb
    sudo rm -f puppet7-release-${DISTRIB_CODENAME}.deb
    sudo apt-get install -f
    sudo apt-get update -y
    sudo apt-get install puppet-agent -y
    sudo apt-get upgrade -y
fi
# Install GIT
sudo apt-get install git -y
# Install r10k
echo "Checking / Installing r10k"
${PUPPET_BIN}/gem query --name r10k --installed &> /dev/null || sudo ${PUPPET_BIN}/gem install r10k

if [ ! -e "$PUPPET_DIR/bin/r10k" ]; then
    sudo ln -s ${PUPPET_BIN}/r10k ${PUPPET_DIR}/bin/r10k
fi
