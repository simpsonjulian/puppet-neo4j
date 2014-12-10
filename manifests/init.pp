# == Class: neo4j
#
# Main class for users to declare.  Delegates to OS specific implementations.
#
# === Parameters
#
# None.
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
class neo4j {
  case $::operatingsystem {
    /^(Debian|Ubuntu)$/:{ include ubuntu  }
    default:            { fail('Sorry, we do not support your OS yet.\
      You can raise a GitHub issue on neo4j-contrib/neo4j-puppet if you like')}
  }

  include neo4j::linux

  class {
    'apt':;
    'java':
      distribution => 'jre';
  }
}
