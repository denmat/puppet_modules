class integration::testing::install_testing_packages {

    $testing_package_list = hiera_hash('testing_packages')
    
    create_resources(package, $testing_package_list)
}
