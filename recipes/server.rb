#
# Cookbook Name:: jira
# Recipe:: server
#
# Copyright 2012, SecondMarket Labs, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'java'

execute 'untar-jira-tarball' do
  cwd node['jira']['parentdir']
  command "tar zxf #{Chef::Config[:file_cache_path]}/#{node['jira']['tarball']}"
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['jira']['tarball']}" do
  source node['jira']['url']
  action :nothing
  notifies :run, 'execute[untar-jira-tarball]', :immediately
end

http_request "HEAD #{node['jira']['url']}" do
  message ''
  url node['jira']['url']
  action :head
  if File.exist?("#{Chef::Config[:file_cache_path]}/#{node['jira']['tarball']}")
    headers 'If-Modified-Since' => File.mtime("#{Chef::Config[:file_cache_path]}/#{node['jira']['tarball']}").httpdate
  end
  notifies :create, "remote_file[#{Chef::Config[:file_cache_path]}/#{node['jira']['tarball']}]", :immediately
end

user 'jira' do
  comment 'Atlassian JIRA'
  home node['jira']['homedir']
  system true
  action :create
end

template '/etc/profile.d/jira.sh' do
  source 'jira-profile.sh.erb'
  owner 'root'
  group 'root'
  mode 00755
  variables(
    :jira_home => node['jira']['homedir']
  )
  action :create
end

directory node['jira']['homedir'] do
  owner 'jira'
  mode 00755
  action :create
end

# Per https://confluence.atlassian.com/display/JIRA051/Installing+JIRA+from+an+Archive+File+on+Windows%2C+Linux+or+Solaris only these dirs need to be owned by "jira"
%w(logs temp work).each do |d|
  directory "#{node['jira']['installdir']}/#{d}" do
    owner 'jira'
    mode 00755
    action :create
  end
end

template "#{node['jira']['installdir']}/atlassian-jira/WEB-INF/classes/jira-application.properties" do
  source 'jira-application.properties.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    :jira_workdir => node['jira']['homedir']
  )
  action :create
  notifies :restart, 'service[jira]'
end

if node['init_package'] == 'systemd'
  execute 'systemctl-daemon-reload' do
    command '/bin/systemctl --system daemon-reload'
    action :nothing
  end

  template '/etc/systemd/system/jira.service' do
    source 'jira.systemd.erb'
    owner 'root'
    group 'root'
    mode 00755
    variables(
      :jira_base => node['jira']['installdir'],
      :user => node['jira']['user']
    )
    action :create
    notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  end
else
  template '/etc/init.d/jira' do
    source 'jira.init.erb'
    owner 'root'
    group 'root'
    mode 00755
    variables(
      :jira_base => node['jira']['installdir'],
      :user => node['jira']['user']
    )
    action :create
  end
end

service 'jira' do
  supports :status => true, :restart => true
  action [:enable, :start]
end
