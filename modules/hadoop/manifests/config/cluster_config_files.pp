class hadoop::config::cluster_config_files inherits hadoop::cluster_config  {

  if $::hitwise_role == 'hadoop_namenode' {
    $get_service = $roles::hadoop_namenode::services
  } elsif  $::hitwise_role == 'hadoop_datanode' {
    $get_service = $roles::hadoop_datanode::services
  } else {
    service {"fake_service": start => '/bin/true', stop => '/bin/true', ensure => false, enable => false }
    $get_service = 'fake_service'
  } 
  

  File ["$hadoop::config::hadoop_config_dir/hdfs-site.xml"] {  
    notify  => Service[$get_service],
    require => Service[$get_service],
    content => template('hadoop/config/hdfs-site.xml.erb'),
  }
  File ["$hadoop::config::hadoop_config_dir/core-site.xml"] {  
    notify  => Service[$get_service],
    require => Service[$get_service],
    content => template('hadoop/config/core-site.xml.erb'),
  }
  File ["$hadoop::config::hadoop_config_dir/mapred-site.xml"] {  
    notify  => Service[$get_service],
    require => Service[$get_service],
    content => template('hadoop/config/mapred-site.xml.erb'),
  }
  File ["$hadoop::config::hadoop_config_dir/hadoop-env.sh"] {
    source => "puppet:///modules/hadoop/client/hadoop-env.sh"
  }
  File ["$hadoop::config::hadoop_config_dir/log4j.properties"] {
    source => "puppet:///modules/hadoop/client/log4j.properties"
  }
  File ["$hadoop::config::hadoop_config_dir/fair-scheduler.xml"] {
    notify  => Service[$get_service],
    require => Service[$get_service],
    content => template('hadoop/config/fair-scheduler.xml.erb'),
  }
 
  File <| tag == 'hadoop_config_cluster_files' |> 
} #end class

