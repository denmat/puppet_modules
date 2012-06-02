# Class: hadoop::config::datanode
#
# Description:
# This configures the datanode node for hadoop 
# data processing.
#
# This class does the following:
#   * create users and groups
#   * create directories
#   * configure files
#   * set crontabs
#
# == Parameters
# None
#
# == Variables
# None
#
# == Requires
# hadoop::config - class
#
# == Example
# node somehost  {
#   include hadoop::config::datanode
# }
#
# == Authors
# Dennis Matotek <dennis.matotek@hitwise.com>
#
# == Copyright
# Copyright 2012 Hitwise Pty Ltd
class hadoop::config::datanode {
  include hadoop::config
 
  # realise the user and group and the configfiles 
  Group <| tag == 'hadoop_node' |> -> 
  User <| tag == 'hadoop_node' |> -> 
  File <| tag == 'hadoop_config_cluster_files' |>

  hadoop::config::create_hadoop_dn_dirs {$hadoop::config::hadoop_default_dirs: }

} #end class
