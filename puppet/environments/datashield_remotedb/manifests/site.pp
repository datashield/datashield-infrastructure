# Datashield server without data and which connects to remote database servers.
#
# Does not install mysql server or a mongodb server or test data but does install the firewall. Update opal
# admin password. Registers remote db server(s) with Opal.
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
  test_data                   => false,                         # No test data
  firewall                    => true,                          # Install firewall on server and open ports
  mysql                       => false,                         # Do not install mysql server
  mongodb                     => false,                         # Do not install mongodb server
  remote_mongodb              => true,                          # Connect to remote mongodb server (or set to false if no mongodb server)
  remote_mongodb_url          => '192.168.2.21:27017',          # Remote mongodb server url
  remote_mongodb_user         => 'opaluser',                    # Username for remote mongodb server
  remote_mongodb_pass         => 'opalpass',                    # Password for remote mongodb server
  remote_mongodb_opal_data_db => 'opal_data',                   # Name of the database holding Opal data
  remote_mongodb_opal_ids_db  => 'opal_ids',                    # Name of the database holding Opal IDs
  remote_mongodb_auth_db      => 'admin',                       # Database for authenticating mongoDB user
  remote_mysql                => true,                          # Connect to remote mysql server (or set to false if no mysql server)
  remote_mysql_url            => '192.168.2.21:3306',           # Remote mysql server url
  remote_mysql_user           => 'opaluser',                    # Username for remote mysql server
  remote_mysql_pass           => 'opalpass',                    # Password for remote mysql server
  remote_mysql_opal_data_db   => 'opal_data',                   # Name of the database holding Opal data
  remote_mysql_opal_ids_db    => 'opal_ids',                    # Name of the database holding Opal IDs
  opal_password_hash          => $opal_password_hash,           # Change Opal admin password using this hash
  opal_password               => 'datashield_test&'             # This is the Opal admin password for Opal management
}