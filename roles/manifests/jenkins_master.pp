class roles::jenkins_master {

  $repos = hiera("yum_repos")
    
  create_resources(yumrepo, $repos)

  include integration::jenkins::jenkins_config

}
