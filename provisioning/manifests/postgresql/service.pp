class provisioning::postgresql::service {

  service { "postgresql": 
    ensure     => true,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
