actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :interface, :kind_of => String, :default => "lo1"
attribute :ipaddress, :kind_of => String, :default => "192.168.100.1"
