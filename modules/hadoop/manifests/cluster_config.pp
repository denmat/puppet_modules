class hadoop::cluster_config {
  include config

  File <| tag == 'common_config_files' |>

  @file {"$hadoop::config::hadoop_config_dir/hdfs-site.xml":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    require => File["$hadoop::config::hadoop_config_dir"],
    tag     => 'hadoop_config_cluster_files',
  }

  @file {"$hadoop::config::hadoop_config_dir/core-site.xml":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    require => File["$hadoop::config::hadoop_config_dir"],
    tag     => 'hadoop_config_cluster_files',
  }
  @file {"$hadoop::config::hadoop_config_dir/mapred-site.xml":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    require => File["$hadoop::config::hadoop_config_dir"],
    tag     => 'hadoop_config_cluster_files',
  }

  @file {"$hadoop::config::hadoop_config_dir/hadoop-env.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    require => File["$hadoop::config::hadoop_config_dir"],
    tag     => 'hadoop_config_cluster_files',
  }
  @file {"$hadoop::config::hadoop_config_dir/log4j.properties":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    require => File["$hadoop::config::hadoop_config_dir"],
    tag     => 'hadoop_config_cluster_files',
  }


  @file {"$hadoop::config::hadoop_config_dir/fair-scheduler.xml":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    require => File["$hadoop::config::hadoop_config_dir"],
    tag     => 'hadoop_config_cluster_files',
   }
 
} #end class
