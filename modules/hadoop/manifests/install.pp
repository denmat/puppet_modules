class hadoop::install {

  $hadoop_package_list = hiera('hadoop_packages')

  package {$hadoop_package_list: 
    ensure  => present, 
    require => [Exec["hadoop_makecache"],Yumrepo["cloudera-cdh3"]],
  }

  exec {"hadoop_makecache": 
    command     => "/usr/bin/yum makecache",
    refreshonly => true, 
  }
   
} #end class
