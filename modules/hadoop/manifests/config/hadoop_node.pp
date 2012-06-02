# Class: hadoop::config::hadoop_node
#
# Description:
# This configures the hadoop_node node for hadoop 
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
#   include hadoop::config::hadoop_node
# }
#
# == Authors
# Dennis Matotek <dennis.matotek@hitwise.com>
#
# == Copyright
# Copyright 2012 Hitwise Pty Ltd
class hadoop::config::hadoop_node {
  include hadoop::config
 
  # realise the user and group and the configfiles 
  Yumrepo <| tag == 'hadoop_repos' |> ->
  Group <| tag == 'accounts-scm' |> -> 
  Group <| tag == 'hadoop_node' |> -> 
  User <| tag == 'accounts-scm' |> -> 
  User <| tag == 'hadoop_node' |> -> 
  File <| tag == 'accounts-scm' |> ->
  Ssh_authorized_key <| tag == 'accounts-scm' |>

} #end class
