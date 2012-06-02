class hadoop::install::hadoop_pig {
 
  $hadoop_hadoop_pig_list = "hadoop-pig"

  package {$hadoop_hadoop_pig_list: ensure => latest }
 
} #end class

