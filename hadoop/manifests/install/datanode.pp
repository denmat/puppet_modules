class hadoop::install::datanode {

  $hadoop_namenode_list = "hadoop-0.20-datanode"

  package {$hadoop_namenode_list: 
    ensure  => latest, 
    require => Package['jre-1.6.0_31-fcs.x86_64'] 
  }
 
} #end class

