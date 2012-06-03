class hadoop::repo {
  $hadoop_repos            = hiera('yumrepos::cloudera')
  $hadoop_repos_defaults   = { enabled => 1 }

  # create repositories
  create_resources(yumrepo, $hadoop_repos, $hadoop_repos_defaults)
}
