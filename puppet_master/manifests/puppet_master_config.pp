class puppet_master::puppet_master_config {
  include puppet_master::httpd
  include puppet_master::httpd::httpd_config

  require puppet_master::puppet_master_install

  $puppet_base               = "/etc/puppet"
  $puppet_env                = "$puppet_base/environments"
  $puppet_env_prod           = "$puppet_base/environments/production"
  $puppet_env_prod_data      = "$puppet_base/environments/production/data"
  $puppet_env_prod_com_mods  = "$puppet_base/environments/production/common_modules"
  $puppet_env_prod_loc_mods  = "$puppet_base/environments/production/modules"

  file { [$puppet_base, $puppet_env, $puppet_env_prod, $puppet_env_prod_data, $puppet_env_prod_com_mods, $puppet_env_prod_loc_mods ]: 
    ensure => directory,
    owner  => puppet,
    group  => root,
    mode   => 0755
  }

  file {"/etc/puppet/puppet.conf":
    ensure => present,
    owner  => puppet,
    mode   => 0644,
    source => '/etc/puppet/setup/files/master/puppet.conf',
    notify => Service['httpd']
  }

  file {"/etc/puppet/puppetdb.conf":
    ensure => present,
    owner  => puppet,
    mode   => 0644,
    source => '/etc/puppet/setup/files/master/puppetdb.conf',
    notify => Service['httpd']
  }

  file {"/etc/puppet/routes.yaml":
    ensure => present,
    owner  => puppet,
    mode   => 0644,
    source => '/etc/puppet/setup/files/master/routes.yaml',
    notify => Service['httpd']
  }

  file {"/etc/puppet/hiera.yaml":
    ensure => present,
    owner  => puppet,
    mode   => 0644,
    source => '/etc/puppet/setup/files/master/hiera.yaml',
  }

  file {"/etc/httpd/conf.d/puppetmaster.conf":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 0644,
    source => '/etc/puppet/setup/files/master/puppetmaster.conf',
    notify  => Service['httpd']
  }

  file {["/var/www/html","/var/www/html/puppet","/var/www/html/puppet/rack", "/var/www/html/puppet/rack/public"]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0755,
  }

  file {"/var/www/html/puppet/rack/config.ru":
    ensure => present,
    owner  => puppet,
    group  => root,
    mode   => 0444,
    source => '/etc/puppet/setup/files/master/config.ru',
  }

  file {"/var/lib/puppet/reports":
    ensure => directory,
    owner  => puppet,
    group  => root,
    mode   => 0750,
  }
    
  # bug http://projects.puppetlabs.com/issues/6112 forces the /bin/true
  exec {'generate_master_cert':
    command => '/usr/bin/puppet cert generate puppetca.mylocal --dns_alt_names=puppetca,puppet.mylocal ; /bin/true',
    creates => '/var/lib/puppet/ssl/private_keys/puppetca.mylocal.pem',
    before  => File['/etc/httpd/conf.d/puppetmaster.conf'],
  }
}  
