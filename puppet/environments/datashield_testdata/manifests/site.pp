# Datashield server with test data.
#
# Install mysql and mongodb, include test data and install the firewall. Update opal admin password
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
  test_data          => true,                   # Install the test data
  firewall           => true,                   # Install firewall on server and open ports
  mysql              => true,                   # Install mysql server
  mongodb            => true,                   # Install mongodb server
  remote_mongodb     => false,                  # No remote mongodb servers
  remote_mysql       => false,                  # No remote mysql servers
  opal_password_hash => $opal_password_hash,    # Change Opal admin password using this hash
  opal_password      => 'datashield_test&'      # This is the Opal admin password for Opal management
}