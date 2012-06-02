class hadoop::install::namenode {
  include hadoop::install

  $hadoop_namenode_list = "hadoop-0.20-namenode"

  package {$hadoop_namenode_list: ensure => latest, require => Package[$hadoop::install::hadoop_package_list] }
 
} #end class

