class hadoop::namenode::namenode_format {

  # here is where we format the HDFS. We have a 2 minute grace time built into the
  # formatting -- enough time to warn people. 
    notify {"formatting_warning": 
      require => [Package['hadoop-0.20-namenode'], Hadoop::Namenode::Create_namenode_dirs[$hadoop::config::hadoop_default_dirs]] 
    } ->

    exec {"format_hdfs":
      command => "/usr/bin/sudo -u hdfs sh -c 'yes Y | /usr/bin/hadoop --config /etc/hadoop/conf namenode -format'",
      onlyif  => "/usr/bin/test `sudo -u hdfs hadoop dfs -ls /mapred |grep -c mapred` -ne 1"
    } ->
    exec {"start_hadoop_for_config":
      command => "/sbin/service hadoop-0.20-namenode start",
      require => Exec["format_hdfs"],
    } ->
    exec {"set_perms_for_hdfs": 
      command => "/bin/hostname $::hostname ;/bin/sleep 30s ;/usr/bin/sudo -u hdfs hadoop fs -mkdir /tmp && /usr/bin/sudo -u hdfs hadoop fs -chmod -R 1777 /tmp && /usr/bin/sudo -u hdfs hadoop fs -mkdir /mapred/system && /usr/bin/sudo -u hdfs hadoop fs -chown mapred:hadoop /mapred/system && /usr/bin/sudo -u hdfs hadoop fs -chmod 700 /mapred/system && /usr/bin/sudo -u hdfs hadoop fs -chmod 755 / && /usr/bin/sudo -u hdfs hadoop fs -chown hdfs:hadoop /",
      require => Exec["start_hadoop_for_config"],
    }
  
} #end class
