# Datashield for Travis testing.
#
# Install mysql and mongodb, include test data but don't install the firewall.
#

class { ::datashield:
  test_data      => true,
  firewall       => false,
  mysql          => true,
  mongodb        => true,
  remote_mongodb => false,
  remote_mysql   => false,
}