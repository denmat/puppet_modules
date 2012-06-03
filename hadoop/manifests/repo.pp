class hadoop::repo {
  $hadoop_repos            = hiera('yumrepos::cloudera')
  $hadoop_repos_defaults   = { enabled => 1, notify => Exec['makecache'] }

  # create repositories
  create_resources(yumrepo, $hadoop_repos, $hadoop_repos_defaults)

  exec {"makecache":
    command => '/usr/bin/yum makecache',
    refreshonly => true,
  }
}
