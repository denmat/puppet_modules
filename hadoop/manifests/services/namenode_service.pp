class hadoop::services::namenode_service {

  $namenode_service = hiera('hadoop::namenode_service')

  create_resources(service, $namenode_service)

}
