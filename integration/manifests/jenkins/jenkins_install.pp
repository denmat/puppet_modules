class integration::jenkins::jenkins_install {

  $deps_jenkins_package_list = ['java-1.6.0-openjdk', 'wget']

  
  package {$deps_jenkins_package_list: ensure => present, before => Package['jenkins'] }

  exec {"get_jenkins_repo":
    command => '/usr/bin/wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo',
    creates => '/etc/yum.repos.d/jenkins.repo',
    notify  => Exec['key_import'],
  }

  exec {"key_import":
    command => '/bin/rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key',
    refreshonly => true,
  }

  package { "jenkins": ensure => present, require => [Exec['get_jenkins_repo'],Exec['key_import']] }

}
