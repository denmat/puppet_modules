class hadoop::client::hadoop_client {
  include hadoop::config

  Group <| tag == 'hadoop_node' |> -> 
  User  <| tag == 'hadoop_node' |> ->
  File  <| tag == 'hadoop_default_dirs' |> -> 
  File  <| tag == 'common_config_files' |> -> 
  Exec  <| tag == 'common_execs' |>  ->

  class {"hadoop::client::cluster_config_files": }


} #end class
