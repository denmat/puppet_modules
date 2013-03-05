class puppet_master::dnsmasq::dnsmasq_config {
    require puppet_master::dnsmasq::dnsmasq_install

    $dns_template = "# Puppet created dns file
# Include a another lot of configuration options.
conf-dir=/etc/dnsmasq.d
"
    $dns_loc = "#Puppet created dns file
server=/mylocal/$ip_address
local=/mylocal/
"

    file {"/etc/dnsmasq.conf":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => 0644,
      content => $dns_template,
      require => Package['dnsmasq'],
    }

    file {"/etc/dnsmasq.d/local":
      ensure   => present,
      owner    => root,
      group    => root,
      mode     => 0644,
      content  => $dns_loc,
      require  => File['/etc/dnsmasq.conf']
    }

    service {"dnsmasq":
      ensure     => true,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
}  

