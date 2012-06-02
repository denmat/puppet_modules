class hadoop::config::datanode {
  include hadoop::config
 
  # realise the user and group and the configfiles 
  Group <| tag == 'hadoop_node' |> -> 
  User <| tag == 'hadoop_node' |> -> 
  File <| tag == 'hadoop_config_cluster_files' |>

  hadoop::config::create_hadoop_dn_dirs {$hadoop::config::hadoop_default_dirs: }

} #end class
