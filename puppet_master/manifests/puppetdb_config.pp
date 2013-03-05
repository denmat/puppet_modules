class puppet_master::puppetdb_config {

  require puppet_master::puppetdb_install 

  exec {'postgres_rake': 
    cwd  => '/etc/puppet/setup',
    command => '/usr/bin/rake postgres:new_install',
  }
  exec {'puppetdb_rake':
    cwd => '/etc/puppet/setup',
    command => '/usr/bin/rake puppetdb:puppetdb_config',
    require => Exec['postgres_rake'],
  }
  exec {'puppetdb_ssl_rake':
    cwd => '/etc/puppet/setup',
    command => '/usr/bin/rake puppetdb:keygen_puppetdb',
    require => Exec['puppetdb_rake'],
  }

}
