class puppet_master::httpd::httpd_config {

    require puppet_master::httpd::httpd_install

    service {'httpd':
      ensure     => true,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
    }
}

