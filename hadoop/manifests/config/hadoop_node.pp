class hadoop::config::hadoop_node {
  include hadoop::config
 
  # realise the user and group and the configfiles 
  Group <| tag == 'hadoop_node' |> -> 
  User <| tag == 'hadoop_node' |> -> 

} #end class
