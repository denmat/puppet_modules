class hadoop::namenode::cluster_config_files {

  File {  ensure  => present,
          require => Package['hadoop-0.20-namenode'],
          notify  => Service['hadoop-0.20-namenode'],
	  owner   => root,
	  group   => root,
	  mode    => 0644 }

  File <| tag == 'cluster_files' |>

} #end class
