#  This fact determins the hadoop node role based on the hostname.
#

require 'facter'

Facter.add("hadoop_role") do
  setcode do
  nn = %x(rpm -qa |grep namenode -c).chomp
  dn = %x(rpm -qa |grep datanode -c).chomp
  tt = %x(rpm -qa |grep tasktracker -c).chomp
  jt = %x(rpm -qa |grep jobtracker -c).chomp

  hadoop_components = {}
  hadoop_components << "hadoop-namenode" if nn eq 1
  hadoop_components << "hadoop-datanode" if dn eq 1
  hadoop_components << "hadoop-jobtracker" if jb eq 1
  hadoop_components << "hadoop-tasktracker" if tt eq 1

  hadoop_components 
  end
end
