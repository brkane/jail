require 'spec_helper'
require 'rspec/expectations'

RSpec::Matchers.define :append_if_no_line do |path, line|
  match do |chef_run|
    chef_run.find_resources('append_if_no_line').any? do |resource|
      resource.path == path && resource.line == line
    end
  end
end
    
describe 'jail::default' do

  let (:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'adds cloned_interfaces to rc.conf' do
    cloned_interface_string = 'cloned_interfaces="${cloned_interfaces} lo1"'
    expect(chef_run).to append_if_no_line('/etc/rc.conf', cloned_interface_string)
  end
end
