class hadoop::datanode::cluster_config_files {

  File {  ensure  => present,
          require => Package['hadoop-0.20-datanode'],
          notify  => [Service['hadoop-0.20-datanode'],Service['tasktracker']],
	  owner   => root,
	  group   => root,
	  mode    => 0644 }

  File <| tag == 'common_config_files' |> ->

  file {  
  '/etc/hadoop-0.20/conf.default/hdfs-site.xml':
    ensure  => present,
    content => template("hadoop/config/hdfs-site.xml.erb");
  '/etc/hadoop-0.20/conf.default/core-site.xml':
    ensure  => present,
    content => template("hadoop/config/core-site.xml.erb");
  '/etc/hadoop-0.20/conf.default/mapred-site.xml':
    ensure  => present,
    content => template("hadoop/config/mapred-site.xml.erb");
  '/etc/hadoop-0.20/conf.default/hadoop-env.sh':
    ensure  => present,
    source  => 'puppet:///modules/hadoop/client/hadoop-env.sh';
  '/etc/hadoop-0.20/conf.default/log4j.properties':
    ensure  => present,
    source  => 'puppet:///modules/hadoop/client/log4j.properties';
  }

} #end class
