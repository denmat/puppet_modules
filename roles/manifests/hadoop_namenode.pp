class roles::hadoop_namenode {

  include hadoop::install::jobtracker
  include hadoop::install::tasktracker
  include hadoop::namenode::config
  include hadoop::datanode::config
  include hadoop::services::jobtracker
  include hadoop::services::tasktracker
  include hadoop::services::datanode
  include hadoop::services::namenode
}
