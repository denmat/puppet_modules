class hadoop::install::jobtracker {
  include hadoop::install

  $hadoop_jobtracker_list = "hadoop-0.20-jobtracker"

  package {$hadoop_jobtracker_list: ensure => latest }
 
} #end class

