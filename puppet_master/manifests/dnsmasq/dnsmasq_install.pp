class puppet_master::dnsmasq::dnsmasq_install {

    $dnsmasq_package_list = ['dnsmasq']

    package {$dnsmasq_package_list: ensure => 'latest' }

} 

