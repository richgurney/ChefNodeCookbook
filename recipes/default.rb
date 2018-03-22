#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update

# nginx
package 'nginx'

service 'nginx' do
  action [:enable, :start]
end

template '/etc/nginx/sites-available/default' do
  source 'proxy.conf.erb'
  owner 'root'
  group 'root'
  mode '0750'
  notifies :reload, 'service[nginx]'
end

# install nodejs
remote_file '/tmp/nodesource_setup.sh' do
  source 'https://deb.nodesource.com/setup_8.x'
  action :create
end

execute 'update node resources' do
  command 'sh /tmp/nodesource_setup.sh'
end

package 'nodejs' do
  action :upgrade
end
