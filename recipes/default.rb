platform = 'windows' if node['platform_family'] == 'windows'
platform ||= 'linux'
settings = Stash.settings(node)

if node['platform_family'] == 'rhel' && node['platform_version'].to_f < 7
  include_recipe 'git::source'
else
  include_recipe 'git'
end
include_recipe 'perl'

include_recipe 'p-stash::database' if settings['database']['host'] == 'localhost'
include_recipe "p-stash::#{platform}_#{node['stash']['install_type']}"
include_recipe 'p-stash::tomcat_configuration'
include_recipe 'p-stash::apache2'
include_recipe 'p-stash::configuration'
include_recipe "p-stash::service_#{node['stash']['service_type']}"
include_recipe 'p-stash::backup_client' if node['stash']['backup_client']['version']
