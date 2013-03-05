class puppet_master::puppetdb_install {

  $puppetdb_packages = { 'puppetdb' => { 'ensure' => 'present' },
                         'postgresql-server' => { 'ensure' => 'present' } }

  create_resources(package, $puppetdb_packages)

}
