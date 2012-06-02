class dns::add_node {

  include dns::dnsmasq::dnsmasq_service
  
  $dns_hosts = hiera('dns_hosts')
  $defaults = { notify => Service['dnsmasq'] }
  
  create_resources(host, $dns_hosts, $defaults)
  


}

  
