class hadoop::datanode::config {
  include hadoop::config
  include hadoop::install::datanode
  include hadoop::datanode::cluster_config_files


  # realise the user and group and the configfiles 
  Group <| tag == 'hadoop_node' |> -> 
  User <| tag == 'hadoop_node' |> -> 
  File <| tag == 'hadoop_default_dirs' |> ->
  File <| tag == 'common_config_files' |> ->

  hadoop::datanode::create_datanode_dirs {$hadoop::config::hadoop_default_dirs:  } 

  
} #end class
