# Datashield for Travis testing.
#
# Install mysql and mongodb, include test data but don't install the firewall.
#

class { ::datashield:
  test_data      => true,         # Install the test data
  firewall       => false,        # Do not install the firewall
  mysql          => true,         # Install mysql server
  mongodb        => true,         # Install mongodb server
  remote_mongodb => false,        # There is not a remote mongodb server
  remote_mysql   => false,        # There is not a remote mysql server
}