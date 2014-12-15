# == Class: neo4j::linux
#
# Make required changes to the Linux configuration in accordance with
# the Neo4j manual.
# Thanks to Neo4j contributor Hendy Irawan (https://github.com/ceefour) for this class!
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
#  class { neo4j::linux }
#
# === Authors
#
# Author Name <julian.simpson@neotechnology.com>
#
# === Copyright
#
# Copyright 2012 Neo Technology Inc.
#
class neo4j::linux {
  $replacement_entry = 'session    required   pam_limits.so'
  $original_entry = "# ${replacement_entry}"

  exec {
    'neo4j_security_limits':
      command   => '/bin/sed -i -e \'$a neo4j    soft    nofile    40000\' \
      -e \'$a neo4j    hard    nofile    40000\' \
      /etc/security/limits.conf',
      logoutput => true,
      unless    => '/bin/grep "neo4j" /etc/security/limits.conf';

    'neo4j_pam_limits':
      command   => "/bin/sed -i -e \'s/${original_entry}/${replacement_entry}/\'\
        /etc/pam.d/su",
      logoutput => true,
      onlyif    => "/bin/grep '${original_entry}' /etc/pam.d/su";
    }

}
