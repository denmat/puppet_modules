class hadoop::namenode::config {
  require hadoop::config
  include hadoop::install::namenode
  include hadoop::namenode::cluster_config_files

  # This sets the option to format the hdfs -- warning --warning.
  # If you pass the --environment build parameter when running puppet on
  # the hadoop cluster, it will format the hdfs - which destroys the data
  # on the cluster. 

  # realise the user and group and the configfiles 
  Group <| tag == 'hadoop_node' |> -> 
  User <| tag == 'hadoop_node' |> -> 
  File <| tag == 'hadoop_default_dirs' |> ->
  file { '/usr/lib/hadoop-0.20/logs/SecurityAuth.audit':
    ensure  => present,
    owner   => 'hdfs',
    mode    => 0644,
    require => Package['hadoop-0.20-namenode']
  } ->
  Exec <| tags == 'common_execs' |> ->

  hadoop::namenode::create_namenode_dirs {$hadoop::config::hadoop_default_dirs:  }  ->

  class {"hadoop::namenode::namenode_format":  }
  
} #end class
