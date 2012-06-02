class hadoop::services::datanode {

  $datanode_service = hiera('hadoop::datanode_service')

  create_resources(service, $datanode_service)

}
