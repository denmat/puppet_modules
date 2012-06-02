define hadoop::config::common_dirs {

  $disklist = $name

  file {"${disklist}/hadoop":
    ensure  => directory,
    owner   => 'hdfs',
    group   => 'hadoop',
    mode    => 0755,
    tag     => 'common_cluster_dirs',
  }
  file {"${disklist}/hadoop/dfs":
    ensure  => directory,
    owner   => 'hdfs',
    group   => 'hadoop',
    mode    => 0755,
    require => File["${disklist}/hadoop"],
    tag     => 'common_cluster_dirs',
  }

} #end class

