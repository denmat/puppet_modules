class hadoop::services::tasktracker {

  $tasktracker_service = hiera('hadoop::tasktracker_service')

  create_resources(service, $tasktracker_service)

}
