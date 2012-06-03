class hadoop::config {
  class {'hadoop::repo': stage => repos }
  include hadoop::install::common
  include hadoop::services::iptables

  # common hadoop settings:
  $hadoop_config_dir       = "/etc/hadoop-0.20/conf.default"
  $hadoop_namenode        =  hiera('hadoop_namenode')
  $hadoop_jobtracker       = hiera('hadoop_jobtracker')
  $hadoop_default_dirs     = hiera('hadoop_default_dirs')
  $hadoop_fs_replication   = hiera('hadoop_fs_replication')
  $hadoop_map_tasks_max    = hiera('hadoop_map_tasks_max')
  $hadoop_reduce_tasks_max = hiera('hadoop_reduce_tasks_max')

  @file { $hadoop_default_dirs:
    ensure => directory,
    mode   => 0755,
    tag    => 'hadoop_default_dirs',
  }

  @file { "/etc/profile.d/java.sh":
    content => "export JAVA_HOME=/usr/java/latest/jre",
    tag     => 'common_config_files',
  }

  @file { "/etc/hadoop-0.20":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0755,
    tag    => 'common_config_files',
  }

  @file { "/etc/hadoop-0.20/conf.default":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0755,
    require => Package['hadoop-0.20'],
    tag    => 'common_config_files',
  }

  @file { "/var/log/hadoop-0.20":
    ensure => directory,
    owner  => 'hdfs',
    group  => 'mapred',
    mode   => 0775,
    tag    => 'common_config_files',
  }

  if hadoop_role !~ /client/ {
    hadoop::config::common_dirs { $hadoop_default_dirs: }
  }

  exec {"set_config_alternatives":
    command => "/usr/sbin/alternatives --install /etc/hadoop-0.20/conf hadoop-0.20-conf /etc/hadoop-0.20/conf.default 50",
    onlyif  => "/usr/bin/test `alternatives --display hadoop-0.20-conf |grep -c 'version is /etc/hadoop-0.20/conf.default'` -ne 1",
    require => File["/etc/hadoop-0.20/conf.default"],
    tag    => 'common_execs',
  }
    
  # Hadoop users will only be realized on the hadoop cluster.
  @user {"hdfs":
    ensure     => present,
    home       => "/usr/lib/hadoop-0.20",
    shell      => "/bin/bash",
    managehome => false,
    uid        => 428,
    gid        => 'mapred',
    groups     => 'hadoop',
    comment    => 'HDFS user -- puppet managed',
    tag        => 'hadoop_node',
  }

  @group {"hdfs":
    ensure => present,
    gid    => 428,
    tag    => 'hadoop_node',
  }

  @user {"mapred":
    ensure     => present,
    home       => "/usr/lib/hadoop-0.20",
    shell      => "/bin/bash",
    managehome => false,
    uid        => 429,
    gid        => 'mapred',
    groups     => 'hadoop',
    comment    => 'MAPRED user -- puppet managed',
    tag        => 'hadoop_node',
  }

  @group {"mapred":
    ensure => present,
    gid    => 429,
    tag    => 'hadoop_node',
  }

  @group {"hadoop":
    ensure => present,
    gid    => 427,
    tag    => 'hadoop_node',
  }

} #end class
