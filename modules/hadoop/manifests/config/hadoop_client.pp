class hadoop::config::hadoop_client {
  include hadoop::config

  # realise the user and group and the configfiles 
  Yumrepo <| tag == 'hadoop_repos' |> ->

  Exec <| tag == 'common_execs' |>


} #end class
