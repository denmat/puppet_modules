class roles::hadoop_datanode {

  class {"hadoop::datanode::config": } -> 
  class {"hadoop::install::tasktracker": } ->
  class {"hadoop::services::datanode": } -> 
  class {"hadoop::services::tasktracker": }

}
