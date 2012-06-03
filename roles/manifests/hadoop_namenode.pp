class roles::hadoop_namenode {

  class {'hadoop::namenode::config': } ->
  class {'hadoop::datanode::config': } ->
  class {'hadoop::install::jobtracker': } ->
  class {'hadoop::install::tasktracker': } ->
  class {'hadoop::services::namenode': } ->
  class {'hadoop::services::jobtracker': } ->
  class {'hadoop::services::tasktracker': } ->
  class {'hadoop::services::datanode': }
}
