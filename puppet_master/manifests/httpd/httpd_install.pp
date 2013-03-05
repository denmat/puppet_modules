class puppet_master::httpd::httpd_install {

    exec {'phusion_repo': 
      command => '/usr/bin/yum install -y http://passenger.stealthymonkeys.com/rhel/6/passenger-release.noarch.rpm',
      creates => '/etc/yum.repos.d/passenger.repo' 
    }

    exec {'epel':
      command => '/usr/bin/yum install -y http://mirror.optus.net/epel/6/i386/epel-release-6-7.noarch.rpm',
      creates => '/etc/yum.repos.d/epel.repo'
    }


    create_resources(package, $httpd_packages)

}

