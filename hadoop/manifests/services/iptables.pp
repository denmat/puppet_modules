class hadoop::services::iptables {
 
 service {"iptables": enable => false, ensure => false }

}
