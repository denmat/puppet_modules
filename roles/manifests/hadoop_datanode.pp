class roles::hadoop_datanode {

  include hadoop::install::jobtracker
  include hadoop::install::tasktracker
  include hadoop::datanode::config
  include hadoop::services::tasktracker
  include hadoop::services::datanode

}
