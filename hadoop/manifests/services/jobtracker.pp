class hadoop::services::jobtracker {

  $jobtracker_service = hiera('hadoop::jobtracker_service')

  create_resources(service, $jobtracker_service)

}
