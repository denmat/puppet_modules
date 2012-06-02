class hadoop::config::hadoop_scm_manager {
  include hadoop::install::cloudera_manager
 
  # realise the user and group and the configfiles 
  Group <| tag == 'accounts-scm' |> -> 
  User <| tag == 'accounts-scm' |> -> 
  File <| tag == 'accounts-scm' |> ->
  File <| tag == 'accounts-scm-client' |> ->
  Ssh_authorized_key <| tag == 'accounts-scm' |>


} #end class
