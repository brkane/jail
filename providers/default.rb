
def whyrun_supported?
  true
end

use_inline_resources

action :create do
  if jail_exists? new_resource.name
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    cmdStr = "ezjail-admin create #{@new_resource.name} '#{@new_resource.interface}|#{@new_resource.ipaddress}'"
    execute cmdStr do
      Chef::Log.debug "ezjail-admin_create: #{cmdStr}"
      environment "PATH" => "/usr/local/bin"
      new_resource.updated_by_last_action(true)
    end
  end
end

def jail_exists?(name)
  cmdStr = "ezjail-admin list | grep '^#{name}\\b'"
  cmd = Mixlib::ShellOut.new(cmdStr)
  cmd.environment['PATH'] = ENV.fetch('PATH', '/usr/local/bin')
  cmd.run_command
  Chef::Log.debug "jail_exists?: #{cmdStr}"
  Chef::Log.debug "jail_exists?: #{cmd.stdout}"
  begin
    cmd.error!
    true
  rescue
    false
  end
end
