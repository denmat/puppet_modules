class puppet_master::java_install {

  $java_packages = { 'java-1.6.0-openjdk.x86_64' => { 'ensure' => 'latest' } }

  create_resources($java_packages)

}
