class hadoop::client::hadoop_client {
  include hadoop::config

  File <| tag == 'common_config_files' |> -> 
  Exec <| tag == 'common_execs' |> 


} #end class
