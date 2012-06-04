require 'spec_helper'

describe 'hadoop::namenode::config' do
  let(:facts) { {:hostname => 'node2', :hadoop_node => 'namenode', :role => 'hadoop_namenode' } }

  let(:title) { 'config' }

  it { should include_class('hadoop::install::namenode') }
end
