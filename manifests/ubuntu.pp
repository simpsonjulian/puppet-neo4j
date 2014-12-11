# == Class: neo4j::ubuntu
#
# Everything you need to get Neo4j running on Ubuntu.  This first draft is meant to be self-contained for first
# time users, we'll see what we can do to make a module that can be user by the Puppet Forge community.
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
#  class { neo4j::ubuntu }
#
# === Authors
#
# Author Name <julian.simpson@neotechnology.com>
#
# === Copyright
#
# Copyright 2012-2014 Neo Technology Inc.
#
class neo4j::ubuntu(
  $data_dir = undef
  ){

  include '::apt'

  apt::source {
    'neo4j_stable':
      comment     => 'Neo4j Stable',
      location    => 'http://debian.neo4j.org/repo',
      key         => '01182252',
      key_source  => 'http://debian.neo4j.org/neotechnology.gpg.key',
      repos       => 'stable/',
      include_deb => true,
      include_src => false,
      release     => ''
  }

  package {
    'neo4j-enterprise':
      require => [Apt::Source['neo4j_stable'], Class['java']]
  }

  service {
    'neo4j-service':
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      require    => Package['neo4j-enterprise'];
  }
  exec {
    'bump the minimum heap size':
      command     => '/bin/echo "wrapper.java.initmemory=1024" >> /etc/neo4j/neo4j-wrapper.conf',
      refreshonly => true,
      require     => Package['neo4j-enterprise'],
      notify      => Service['neo4j-service'],
      unless      => '/bin/grep "^wrapper.java.initmemory" /etc/neo4j/neo4j-wrapper.conf 2>/dev/null';

    'bump the maximum heap size':
      command     => '/bin/echo "wrapper.java.maxmemory=4096" >> /etc/neo4j/neo4j-wrapper.conf',
      refreshonly => true,
      require     => Package['neo4j-enterprise'],
      notify      => Service['neo4j-service'],
      unless      => '/bin/grep "^wrapper.java.maxmemory" /etc/neo4j/neo4j-wrapper.conf 2>/dev/null';
  }

  file {
    'neo4j config file':
      path     => '/etc/neo4j/neo4j-server.properties',
      content  => template('neo4j/neo4j-server.properties.erb'),
      require  => Package['neo4j-enterprise'],
      owner    => neo4j,
      notify   => Service['neo4j-service'],
      group    => adm;

    ['/var/lib/neo4j', '/var/lib/neo4j/data']:
      ensure   => directory;
  }

  class {
    'neo4j::data_store': data_dir => $data_dir
  }

}
