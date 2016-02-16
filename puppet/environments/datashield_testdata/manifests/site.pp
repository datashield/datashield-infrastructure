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
  test_data          => true,
  firewall           => true,
  mysql              => true,
  mongodb            => true,
  remote_mongodb     => false,
  remote_mysql       => false,
  opal_password_hash => $opal_password_hash,
  opal_password      => 'datashield_test&'
}