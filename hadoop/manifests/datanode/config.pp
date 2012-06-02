class hadoop::datanode::config {
  include hadoop::config
  include hadoop::install::datanode

  # realise the user and group and the configfiles 
  Group <| tag == 'hadoop_node' |> -> 
  User <| tag == 'hadoop_node' |> -> 
  File <| tag == 'hadoop_default_dirs' |> ->

  hadoop::datanode::create_datanode_dirs {$hadoop::config::hadoop_default_dirs:  } 

  
} #end class
