class hadoop::install::datanode {
  include hadoop::install 

  $hadoop_datanode_list = "hadoop-0.20-datanode"

  package {$hadoop_datanode_list: ensure => latest, require => Package[$hadoop::install::hadoop_package_list] }
 
} #end class

