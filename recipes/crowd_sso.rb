#
# Cookbook Name:: jira
# Recipe:: crowd_sso
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

template "#{node['jira']['installdir']}/atlassian-jira/WEB-INF/classes/crowd.properties" do
  source "crowd.properties.erb"
  owner  "root"
  group  "root"
  mode   00644
  action :create
  variables(
    :sso_appname => node['jira']['crowd_sso']['sso_appname'],
    :sso_password => node['jira']['crowd_sso']['sso_password'],
    :crowd_base_url => node['jira']['crowd_sso']['crowd_base_url']
  )
  notifies :restart, "service[jira]"
end

# Note: You need to "Configure JIRA to use Crowd's Authenticator to enable SSO" by hand because I can't get xmlstarlet to enable/disable comments. See: https://confluence.atlassian.com/display/CROWD/Integrating+Crowd+with+Atlassian+JIRA
