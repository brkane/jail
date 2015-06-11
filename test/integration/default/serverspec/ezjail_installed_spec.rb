require 'serverspec'

set :backend, :exec

describe package('ezjail') do
  it { should be_installed }
end

describe file('/etc/rc.conf') do
  its(:content) { should match /^ezjail_enable=\"YES\"/ }
end

describe file('/usr/jails/basejail') do
  it { should be_directory }
end
