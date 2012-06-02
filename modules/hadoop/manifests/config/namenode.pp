# Class: hadoop::config::namenode
#
# Description:
# This configures the datanode node for hadoop 
# data processing.
#
# This class does the following:
#   * create users and groups
#   * create directories
#   * configure files
#   * set crontabs
#
# == Parameters
# secondary - if this is a secondary name name set to true
# datanode  - if this namenode is also a datanode set to true
#
# == Variables
# None
#
# == Requires
# hadoop::config - class
#
# == Example
# node somehost  {
#   class {"hadoop::config::namenode": secondary => false, datanode => true }
# }
#
# == Authors
# Dennis Matotek <dennis.matotek@hitwise.com>
#
# == Copyright
# Copyright 2012 Hitwise Pty Ltd
class hadoop::config::namenode ($secondary = false){
  include hadoop::config

  # This sets the option to format the hdfs -- warning --warning.
  # If you pass the --environment build parameter when running puppet on
  # the hadoop cluster, it will format the hdfs - which destroys the data
  # on the cluster. 
  if $::environment == 'build' {
    $format_hdfs_on_namenode = true
  }

  # realise the user and group and the configfiles 
  Group <| tag == 'hadoop_node' |> -> 
  User <| tag == 'hadoop_node' |> 

  file {"/etc/hadoop/conf/masters":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 0644,
    content => template('hadoop/config/masters.erb'),
  }

  file {"/etc/hadoop/conf/slaves":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 0644,
    content => template('hadoop/config/slaves.erb'),
  }

  if $secondary {
    hadoop::config::create_hadoop_nn_dirs {$hadoop::config::hadoop_default_dirs: secondary => true }
  } else {
    hadoop::config::create_hadoop_nn_dirs {$hadoop::config::hadoop_default_dirs: secondary => false }
  }

  # here is where we format the HDFS. We have a 2 minute grace time built into the
  # formatting -- enough time to warn people. 
  if $format_hdfs_on_namenode {
    notify {"formatting_warning": }

    exec {"format_hdfs":
      command => "/bin/sleep 10s; /usr/bin/sudo -u hdfs sh -c 'yes Y | /usr/bin/hadoop --config /etc/hadoop/conf namenode -format' && touch /root/hdfs_formated_`date +%s`",
      require => [Notify["formatting_warning"],Service['hadoop-0.20-namenode']],
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
