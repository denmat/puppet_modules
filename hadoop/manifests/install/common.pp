class hadoop::install::common {

  $common_package_list = hiera('hadoop_common_packages')

  create_resources(package, $common_package_list)
}
