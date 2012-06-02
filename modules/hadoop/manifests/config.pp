class hadoop::config {
  include roles::hadoop_common
  include hadoop::install

  # common hadoop settings:
  $hadoop_config_dir       = "/etc/hadoop-0.20/conf.default"
  $hadoop_name_node        = $roles::hadoop_common::hadoop_name_node
  $hadoop_jobtracker       = $roles::hadoop_common::hadoop_name_node
  $hadoop_slaves           = $roles::hadoop_common::hadoop_name_node
  $hadoop_default_dirs     = $roles::hadoop_common::hadoop_default_dirs
  $hadoop_fs_replication   = $roles::hadoop_common::hadoop_fs_replication
  $hadoop_map_tasks_max    = $roles::hadoop_common::hadoop_map_tasks_max
  $hadoop_reduce_tasks_max = $roles::hadoop_common::hadoop_reduce_tasks_max

  $java_version = $roles::hadoop_common::java_version
 
  @yumrepo { "cloudera-cdh3":
    name       => 'cloudera-cdh3',
    descr      => 'Cloudera yum repository for hadoop',
    mirrorlist => 'http://archive.cloudera.com/redhat/6/x86_64/cdh/3/mirrors',
    gpgkey     => 'http://archive.cloudera.com/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera',
    gpgcheck   => 1,
    tag        => 'hadoop_repos',
  } 

  @yumrepo { "cloudera-scm":
    name       => "cloudera-scm",
    descr      => "Cloudera SCM Manager",
    baseurl    => "http://archive.cloudera.com/scm/redhat/6/x86_64/cloudera-manager/3/",
    gpgkey     => "http://archive.cloudera.com/scm/redhat/6/x86_64/cloudera-manager/RPM-GPG-KEY-cloudera",
    gpgcheck   => 1,
    tag        => 'hadoop_repos',
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


  @exec {"set_config_alternatives":
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
