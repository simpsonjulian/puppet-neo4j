# == Class: neo4j
#
# Main class for users to declare.  Delegates to OS specific implementations.
#
# === Parameters
#
# data_dir - where datafiles should be stored.
#
# === Variables
# None.
#
# === Examples
#
#  class { neo4j }
#
# === Authors
#
# Author Name <julian.simpson@neotechnology.com>
#
# === Copyright
#
# Copyright 2012-2014 Neo Technology Inc.
#
class neo4j(
  $data_dir = '/var/lib/neo4j'
  ) {
  case $::operatingsystem {
    /^(Debian|Ubuntu)$/:{
      class {
        'neo4j::ubuntu':
          data_dir => $data_dir;
      }
    }
    default:            { fail('Sorry, we do not support your OS yet.\
      You can raise a GitHub issue on neo4j-contrib/neo4j-puppet if you like')}
  }

  include java

  class {
    'neo4j::linux':;
  }
}
