class hadoop::config::tasktrackernode {
  include hadoop::config
 
  # realise the user and group
  Group <| tag == 'hadoop_node' |> -> User <| tag == 'hadoop_node' |>
 

} #end class
