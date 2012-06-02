class hadoop::install::tasktracker {
  include hadoop::install 

  $hadoop_tasktracker_list = "hadoop-0.20-tasktracker"

  package {$hadoop_tasktracker_list: ensure => latest }
 
} #end class

