class hadoop::config::client_hadoop_config_files inherits hadoop::cluster_config  {

  File ["$hadoop::config::hadoop_config_dir/hdfs-site.xml"] {  
    source => "puppet:///modules/hadoop/client/hdfs-site.xml"  
  }
  File ["$hadoop::config::hadoop_config_dir/core-site.xml"] { 
    source => "puppet:///modules/hadoop/client/core-site.xml"  
  }
  File ["$hadoop::config::hadoop_config_dir/mapred-site.xml"] {  
    source => "puppet:///modules/hadoop/client/mapred-site.xml"  
  } 
  File ["$hadoop::config::hadoop_config_dir/hadoop-env.sh"] {
    source => "puppet:///modules/hadoop/client/hadoop-env.sh"
  }
  File ["$hadoop::config::hadoop_config_dir/log4j.properties"] {
    source => "puppet:///modules/hadoop/client/log4j.properties"
  }

  File <| tag == 'hadoop_config_cluster_files' |> 
} #end class
