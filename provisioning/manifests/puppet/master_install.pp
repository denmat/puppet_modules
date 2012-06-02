class provisioning::puppet::server_install {
  # collect the puppet package list from hiera.
  # should be like the following
  # puppet_package_list:
  #   - puppet-server:
  #      - provider: yum
  #      - version:  latest
  #   - activerecord:
  #      - provider: gem
  #      - version: 2.0.11

  $puppet_package_list = hiera_hash('puppet_package_list' )
  $puppet_package_deps = hiera_hash('puppet_package_deps' )
  $defaults = { require => Package['ruby-devel'] }

  create_resources ( package, $puppet_package_deps)
  create_resources ( package, $puppet_package_list, $defaults)

}
