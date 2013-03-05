class puppet_master::puppet_master_install {

  require puppet_master::puppet_repos

  $puppet_packages = { 'puppet-server' => { 'ensure' => 'present' },
                       'hiera-puppet' => { 'ensure' => 'latest' },
                       'puppet-dashboard' => { 'ensure' => 'latest' },
                       'puppetdb-terminus' => { 'ensure' => 'latest' }
                      }

  create_resources(package, $puppet_packages)

}
