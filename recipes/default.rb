#
# Cookbook Name:: jail
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

append_if_no_line "create loopback interface for jails" do
  path "/etc/rc.conf"
  line "cloned_interfaces=\"${cloned_interfaces} lo1\""
end

package "ezjail"

service 'ezjail' do
  action :enable
end

execute "setup base jail" do
  command "ezjail-admin install #{node['jail']['install_args']}"
  creates "/usr/jails/basejail"
  environment "PATH" => "/usr/local/bin:#{ENV["PATH"]}"
end

execute 'create lo1 interface' do
  command 'service netif cloneup'
  environment 'PATH' => '/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin'
end
