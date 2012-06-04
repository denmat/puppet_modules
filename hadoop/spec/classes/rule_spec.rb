require 'spec_helper'

describe 'hadoop::namenode::config' do
  let(:facts) { {:hostname => 'node2', :hadoop_node => 'namenode', :role => 'hadoop_namenode' } }

  let(:title) { 'config' }

  it { should include_class('hadoop::install::namenode') }

  it { should contain_file('/usr/lib/hadoop-0.20/logs/SecurityAuth.audit') }
  it { should contain_file('/etc/hadoop-0.20/conf.default/core-site.xml') }

  it { should contain_service('hadoop-0.20-namenode').with_ensure('present') }

end

describe 'hadoop::services::namenode' do

  let(:title) { 'namenode' } 

  it { should contain_service('hadoop-0.20-namenode').with_ensure('true') }

end
