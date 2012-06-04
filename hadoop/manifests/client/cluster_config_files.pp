class hadoop::client::cluster_config_files inherits hadoop::config::cluster_config_files  {

  File {  ensure  => present,
	  owner   => root,
	  group   => root,
	  mode    => 0644 }

  File <| tag == 'common_config_files' |> ->
  File <| tag == 'cluster_files' |>

} #end class
