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

freebsd_package "ezjail"

append_if_no_line "enable ezjail on boot" do
  path "/etc/rc.conf"
  line "ezjail_enable=\"YES\""
end

service "ezjail" do
  action :start
end

execute "setup base jail" do
  command "ezjail-admin install"
  creates "/usr/jails/basejail"
  environment "PATH" => "/usr/local/bin:#{ENV["PATH"]}"
end

execute 'create lo1 interface' do
  command 'service netif cloneup'
  environment 'PATH' => '/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin'
end
