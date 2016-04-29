
def whyrun_supported?
  true
end

use_inline_resources

action :create do
  if jail_exists?
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    cmdStr = "ezjail-admin create #{@new_resource.name} '#{@new_resource.interface}|#{@new_resource.ipaddress}'"
    execute cmdStr do
      Chef::Log.debug "ezjail-admin_create: #{cmdStr}"
      environment "PATH" => "/bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
      new_resource.updated_by_last_action(true)
    end
  end
end

action :start do
  name = @new_resource.name
  if jail_running?
    Chef::Log.info "#{@new_resource} already running - nothing to do."
  elsif !jail_exists?
    raise Chef::Exceptions::Exec, "#{@new_resource} is not created, cannot start"
  else
    cmdStr = "ezjail-admin start #{name}"
    execute cmdStr do
      Chef::Log.debug "ezjail-admin_start: #{cmdStr}"
      environment "PATH" => "/bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
      new_resource.updated_by_last_action(true)
    end
  end
end

def jail_exists?
  ::File.exist?("/usr/local/etc/ezjail/#{@new_resource.name}")
end

def jail_running?
  ::File.exist?("/var/run/jail_#{@new_resource.name}.id")
end
