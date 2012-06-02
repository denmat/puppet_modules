class hadoop::namenode::config {
  include hadoop::config
  include hadoop::install::namenode
  include hadoop::namenode::cluster_config_files

  # This sets the option to format the hdfs -- warning --warning.
  # If you pass the --environment build parameter when running puppet on
  # the hadoop cluster, it will format the hdfs - which destroys the data
  # on the cluster. 
  if $::environment == 'build' {
    $format_hdfs_on_namenode = true
  }

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

  hadoop::namenode::create_namenode_dirs {$hadoop::config::hadoop_default_dirs:  } 

  # here is where we format the HDFS. We have a 2 minute grace time built into the
  # formatting -- enough time to warn people. 
  if $format_hdfs_on_namenode {
    notify {"formatting_warning": 
      require => [Package['hadoop-0.20-namenode'], Hadoop::Namenode::Create_namenode_dirs[$hadoop::config::hadoop_default_dirs]] 
    }

    exec {"format_hdfs":
      command => "/bin/sleep 10s; /usr/bin/sudo -u hdfs sh -c 'yes Y | /usr/bin/hadoop --config /etc/hadoop/conf namenode -format' && touch /root/hdfs_formated_`date +%s`",
      require => [Notify["formatting_warning"],Service['hadoop-0.20-namenode'],Package['hadoop-0.20-namenode']],
    }
    exec {"start_hadoop_for_config":
      command => "/sbin/service hadoop-0.20-namenode start",
      require => Exec["format_hdfs"],
    }
    exec {"set_perms_for_hdfs": 
      command => "/bin/sleep 30s ;/usr/bin/sudo -u hdfs hadoop fs -mkdir /tmp && /usr/bin/sudo -u hdfs hadoop fs -chmod -R 1777 /tmp && /usr/bin/sudo -u hdfs hadoop fs -mkdir /mapred/system && /usr/bin/sudo -u hdfs hadoop fs -chown mapred:hadoop /mapred/system && /usr/bin/sudo -u hdfs hadoop fs -chmod 700 /mapred/system && /usr/bin/sudo -u hdfs hadoop fs -chmod 755 / && /usr/bin/sudo -u hdfs hadoop fs -chown hdfs:hadoop /",
      require => Exec["start_hadoop_for_config"],
    }
  }
  
} #end class
