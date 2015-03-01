require 'spec_helper'

describe 'jail::jail_test' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge('jail::jail_test') }

  it 'creates a jail' do
    expect(chef_run).to create_jail('www.example.com')
  end

  it 'creates a jail with a custom interface' do
    expect(chef_run).to create_jail('www2.example.com').with(interface: 'lo0')
  end

  it 'creates a jail with a custom ip address' do
    expect(chef_run).to create_jail('www3.example.com').with(ipaddress: '192.168.100.10')
  end
end
