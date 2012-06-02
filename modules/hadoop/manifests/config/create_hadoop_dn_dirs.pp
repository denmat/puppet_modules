define hadoop::config::create_hadoop_dn_dirs {

  $disklist = $name

    file {"${disklist}/hdfs":
      ensure => directory,
      owner  => 'hdfs',
      group  => 'hdfs',
      mode   => 0755,
    }
    file {"${disklist}/hdfs/dfs":
      ensure => directory,
      owner  => 'hdfs',
      group  => 'hdfs',
      mode   => 0750,
      require => File["${disklist}/hdfs"],
    }
    file {"${disklist}/hdfs/dfs/data":
      ensure  => directory,
      owner   => 'hdfs',
      group   => 'hadoop',
      mode    => 0700,
      require => File["${disklist}/hdfs/dfs"],
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

