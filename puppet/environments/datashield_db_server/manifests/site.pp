# This creates a database server suitable for storing data for datashield, but does not install datashield or Opal. I.e.
# for a remote database server connceted to a datashield install.
#
# Install mysql and mongodb, no test data and install the firewall. Update opal admin password
# This is an example please change to meet the needs of your install. Consider changing any passwords in this file!
#

class { ::datashield::db_server:
  firewall            => true,                   # Install firewall on server and open ports
  local_only_access   => false,                  # Allow remote access to the databases
  mysql               => true,                   # Install mysql server
  mysql_root_password => 'rootpass',             # Root password for MySQL install
  mysql_user          => 'opaluser',             # MySQL user for Opal databases
  mysql_pass          => 'opalpass',             # MySQL user passport for Opal databases
  mongodb             => true,                   # Install mongodb server
  mongodb_user        => 'opaluser',             # Username of root MongoDB user for MongoDB install
  mongodb_pass        => 'opalpass',             # Password of root MongoDB user for MongoDB install
}