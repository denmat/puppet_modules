define hadoop::datanode::create_datanode_dirs {

  $disklist = $name

    file {"${disklist}/hadoop/dfs/data":
      ensure  => directory,
      owner   => 'hdfs',
      group   => 'hadoop',
      mode    => 0700,
      require => File["${disklist}/hadoop/dfs"],
    }
    file {"${disklist}/mapred":
      ensure  => directory,
      owner   => 'mapred',
      group   => 'mapred',
      mode    => 0755,
    }
    file {"${disklist}/mapred/local":
      ensure  => directory,
      owner   => 'mapred',
      group   => 'hadoop',
      mode    => 0755,
      require => File["${disklist}/mapred"],
    }

} #end class

