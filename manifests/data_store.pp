class neo4j::data_store($data_dir) {
  include neo4j::params

  user {
    $neo4j::params::user:
      ensure => present;
  }

  file {
    ["${data_dir}", "${data_dir}/graph.db"]:
      ensure => directory,
      owner  => $neo4j::params::user,
      group  => $neo4j::params::group;

    '/var/lib/neo4j/data/graph.db':
      ensure  => link,
      target  => "${data_dir}/graph.db",
      notify  => Service['neo4j-service'];
  }

}
