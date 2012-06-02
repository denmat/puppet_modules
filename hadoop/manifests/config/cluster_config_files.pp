class hadoop::config::cluster_config_files {

  File <| tag == 'common_config_files' |> ->

  @file {  
  '/etc/hadoop-0.20/conf.default/hdfs-site.xml':
    ensure  => present,
    content => template("hadoop/config/hdfs-site.xml.erb"),
    tag     => 'cluster_files';
  '/etc/hadoop-0.20/conf.default/core-site.xml':
    ensure  => present,
    content => template("hadoop/config/core-site.xml.erb"),
    tag     => 'cluster_files';
  '/etc/hadoop-0.20/conf.default/mapred-site.xml':
    ensure  => present,
    content => template("hadoop/config/mapred-site.xml.erb"),
    tag     => 'cluster_files';
  '/etc/hadoop-0.20/conf.default/hadoop-env.sh':
    ensure  => present,
    source  => 'puppet:///modules/hadoop/client/hadoop-env.sh',
    tag     => 'cluster_files';
  '/etc/hadoop-0.20/conf.default/log4j.properties':
    ensure  => present,
    source  => 'puppet:///modules/hadoop/client/log4j.properties',
    tag     => 'cluster_files';
  }

} #end class
