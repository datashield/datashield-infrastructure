# Datashield client server
#
# Install R and datashield client packages. Install Rstudio and set up default user for login.
# This is an example please change to meet the needs of your install. Consider changing any passwords in this file!
#

class { ::datashield::client:
  rstudio       => true,                # Install rstudio on the machine
  agate         => true,                # Install Agate
  firewall      => true,                # Install the firewall on the machine
  create_user   => true,                # Create a default user account with rstudio install
  user_name     => 'datashield',        # Name of user to create
  password_hash => 'mrtyHtvJlH8D2'      # Password hash of user to create
}