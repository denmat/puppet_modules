class puppet_master::puppet_repos {

  $puppet_repos = { "puppetlabs" => {
                                     descr   => "puppetlabs-products",
                                     name     => "puppetlabs",
                                     baseurl  => "http://yum.puppetlabs.com/el/6/products/\$basearch",
                                     gpgkey   => "http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs",
                                     enabled  => 1,
                                     gpgcheck => 1
                                    },
               "puppetlabs-deps" => {
                                     descr    => "puppetlabs-deps",
                                     name     => "puppetlabs-deps",
                                     baseurl  => "http://yum.puppetlabs.com/el/6/dependencies/\$basearch",
                                     gpgkey   => "http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs",
                                     enabled  => 1,
                                     gpgcheck => 1
                                    }
                  }

  create_resources(yumrepo, $puppet_repos)

}
