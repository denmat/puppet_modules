class hadoop::install::hadoop_hue {
  include hadoop::install

  $hadoop_hue_list = [ 'hue-common', 'hue-filebrowser', 'hue-jobbrowser', 'hue-jobsub', 'hue-shell' ]

  package {$hadoop_hue_list: ensure => latest }
 
} #end class

