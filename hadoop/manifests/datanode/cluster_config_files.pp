class hadoop::datanode::cluster_config_files inherits hadoop::config::cluster_config_files  {

  File {  ensure  => present,
          require => Package['hadoop-0.20-datanode'],
          notify  => [Service['hadoop-0.20-datanode'],Service['tasktracker']],
	  owner   => root,
	  group   => root,
	  mode    => 0644 }

  File <| tag == 'common_config_files' |> ->
  File <| tag == 'cluster_files' |>

} #end class
