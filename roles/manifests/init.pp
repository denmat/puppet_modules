class roles {

  # add hosts to dns and issue restart of dnsmasq
  class {"dns::add_node": stage => first }

  # add admin users to all hosts.

#  include users
#  if ($::osfamily == 'Debian') {
#    users::create_user {"admin_users": user => 'admin_users', groups => 'admin_groups_ubuntu', require => File['/etc/skel/.ssh'] }
#  } else {
#    users::create_user {"admin_users": user => 'admin_users', groups => 'admin_groups_ec2', require => File['/etc/skel/.ssh'] }
#  }

#  $admin_public_keys = hiera('admin_public_keys')
#  $public_key_defaults = hiera('public_key_defaults')

#  create_resources (ssh_authorized_key, $admin_public_keys, $public_key_defaults)

  # adding sudoers based on roles.
#  include sudo
  # add mcollective for all servers
#  include provisioning::mcollective::mcollective_server_config


  if $::role == 'webserver' {
    include roles::webservices
  }
  if $::role =~ /^db\w+$/ {
    include roles::dbservices
  }
  if $::role == 'ha' {
    include roles::haproxy
  }
  if $::role == 'stgserver' {
    include roles::stg
  }
  if $::role == 'provisioner' {
    include roles::provisioner
  }
  if $::role == 'bastion' {
    include roles::bastion
  }
  if $::role == 'hadoop_namenode' {
    include roles::hadoop_namenode
  }
  if $::role == 'hadoop_datanode' {
    include roles::hadoop_datanode
  }
  if $::role == 'hadoop_client' {
    include roles::hadoop_client
  }
  if $::role == "jenkins_master" {
    include roles::jenkins_master
  }
  if $::role == "jenkins_slave" {
    include roles::jenkins_slave
  }
}
