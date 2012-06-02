# Class: hadoop::config::jobtrackernode
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
#   include hadoop::config::jobtrackernode
# }
#
# == Authors
# Dennis Matotek <dennis.matotek@hitwise.com>
#
# == Copyright
# Copyright 2012 Hitwise Pty Ltd
class hadoop::config::jobtrackernode {
  include hadoop::config

  # realise the user and group
  Group <| tag == 'hadoop_node' |> -> User <| tag == 'hadoop_node' |>
 
} #end class
