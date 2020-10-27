# Datashield server without test data.
#
# Install mysql and mongodb, no test data and install the firewall. Update opal admin password
# This is an example please change to meet the needs of your install. Consider changing any passwords in this file!
#

case $::operatingsystem {
  'Ubuntu': {
    $opal_password_hash = '$shiro1$SHA-256$500000$gcnVxdEmOjaN+NfsK/1NsA==$UOobbhJsBBojnbsfzIBX9GTWjWQFi8aJZxFvFKmOiSE='
  }
  'Centos': {
    $opal_password_hash = '$shiro1$SHA-256$500000$5Zx3jiOtGFLYYqboKSgFgQ==$qUiuEUIMsEfVash4nqtr8A94/GD6B8Kdlv8bll3wg2M='
  }
}

class { ::datashield:
  test_data            => false,                  # No test data
  firewall             => true,                   # Install firewall on server and open ports
  mysql                => true,                   # Install mysql server
  mysql_root_password  => 'rootpass',             # Root password for MySQL install
  mysql_user           => 'opaluser',             # MySQL user for Opal databases
  mysql_pass           => 'opalpass',             # MySQL user passport for Opal databases
  mongodb              => true,                   # Install mongodb server
  mongodb_user         => 'opaluser',             # Username of root MongoDB user for MongoDB install
  mongodb_pass         => 'opalpass',             # Password of root MongoDB user for MongoDB install
  remote_mongodb       => false,                  # No remote mongodb servers
  remote_mysql         => false,                  # No remote mysql servers
  opal_password_hash   => $opal_password_hash,    # Change Opal admin password using this hash
  opal_password        => 'datashield_test&',     # This is the Opal admin password for Opal management
  opal_release         => 'stable'                # The release version of Opal to install.
}
