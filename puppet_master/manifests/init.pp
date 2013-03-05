class puppet_master {

  if $::operatingsystem == 'RedHat' {
    file {'/etc/sudoers.d/setup':
      owner   => root,
      group   => root,
      mode    => 0440,
      content => "Defaults:root !requiretty
",
    }
  }

  class {"puppet_master::dnsmasq": } ->
  puppet_master::dnsmasq::add_node{'puppetca': aliases => ['puppetca.mylocal','puppet.mylocal'] } ->
  class {"puppet_master::puppet_master_config": } ->
  class {"puppet_master::puppetdb_config": }

}
