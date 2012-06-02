Hadoop Client Configuration
---------------------------

This directory contains the necessary set of files needed by a client to connect
to the Hadoop services running on your Cloudera Manager-managed cluster.

You can tell Hadoop to use this configuration by one of the following means:

1) set HADOOP_CONF_DIR=<directory> in the environment to it.

2) Pass --config=<directory> on the command line.

To use this configuration by default, you can use the 'alternatives' mechanism
provided by your Linux distribution:

eg: For RHEL/CentOS:

$ sudo alternatives --install /etc/hadoop-0.20/conf hadoop-0.20-conf <directory> 50

or for SLES:

$ sudo update-alternatives --install /etc/hadoop-0.20/conf hadoop-0.20-conf <directory> 50

More detailed documentation can be found here:

https://ccp.cloudera.com/display/CDHDOC/CDH3+Deployment+on+a+Cluster#CDH3DeploymentonaCluster-CustomizingtheConfigurationwithoutUsingaConfigurationPackage