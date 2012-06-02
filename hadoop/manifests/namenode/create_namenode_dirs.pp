define hadoop::namenode::create_namenode_dirs {
  
  $disklist = $name
  $secondary = hiera('hadoop::namenode::secondarynamenode', undef)

  file {"${disklist}/hadoop/dfs/namenode":
    ensure  => directory,
    owner   => 'hdfs',
    group   => 'hadoop',
    mode    => 0700,
    require => File["${disklist}/hadoop/dfs"],
  }
  file {"${disklist}/hadoop/dfs/namenode/current":
    ensure  => directory,
    owner   => 'hdfs',
    group   => 'mapred',
    mode    => 0755,
    require => File["${disklist}/hadoop/dfs/namenode"],
  }

  if $secondary {
    file {"${disklist}/hadoop/dfs/second_namenode":
      ensure  => directory,
      owner   => 'hdfs',
      group   => 'hadoop',
      mode    => 0700,
      require => File["${disklist}/hadoop/dfs"],
    }
  }
} #end class

