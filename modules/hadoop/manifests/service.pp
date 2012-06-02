define hadoop::service ($enabled = false) {

  if $enabled {
    if $::environment == 'build' {
      $service_running = false
      $service_on = true
    } else {
      $service_running = true
      $service_on = true
    }
  }
  else {
    $service_running = false
    $service_on = false
  }

  if $::hitwise_role == 'hadoop_namenode' {
    $get_service = $roles::hadoop_namenode::services
    $package_list = $roles::hadoop_namenode::services
    $stop_service = $roles::hadoop_namenode::stop_services

    if $stop_service {
      service {$stop_service: ensure => false, enable => false }
    }
  }
  if $::hitwise_role == 'hadoop_datanode' {
    $get_service = $roles::hadoop_datanode::services
    $package_list = $roles::hadoop_datanode::services
    $stop_service = $roles::hadoop_datanode::stop_services

    if $stop_service {
      service {$stop_service: ensure => false, enable => false }
    }  
  }

  service { $get_service:
    enable     => $service_on,
    ensure     => $service_running,
    hasstatus  => true,
    hasrestart => true, 
    require    => Package[$package_list],
  }
 
} #end define 
