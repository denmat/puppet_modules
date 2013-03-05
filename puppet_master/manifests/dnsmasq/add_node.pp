define puppet_master::dnsmasq::add_node($aliases) {
    include puppet_master::dnsmasq::dnsmasq_config
   
    $dns_hosts = { puppetca => {ensure => present, ip => $ipaddress, host_aliases => $aliases }} 
    $defaults = { notify => Service['dnsmasq'] }
  
    create_resources(host, $dns_hosts, $defaults)

}
