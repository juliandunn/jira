#
# Cookbook Name:: jira
# Attributes:: default
#
# Copyright 2012, SecondMarket Labs, LLC.
# Copyright 2013, Chef Software, Inc.
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

default['jira']['user'] = 'jira'

# We need Java 7 for JIRA
default['java']['jdk_version'] = '7'

default['jira']['version'] = '6.4.11'
default['jira']['parentdir'] = '/opt'

# This is what the JIRA Installation docs refer to as the "JIRA Installation Directory"
default['jira']['installdir'] = "#{node['jira']['parentdir']}/atlassian-jira-#{node['jira']['version']}-standalone"
default['jira']['tarball'] = "atlassian-jira-#{node['jira']['version']}.tar.gz"
default['jira']['url'] = "http://www.atlassian.com/software/jira/downloads/binary/#{node['jira']['tarball']}"

# This is what the JIRA Installation docs refer to as the "JIRA Home Directory"
default['jira']['homedir'] = '/var/jira-home'

default['jira']['crowd_sso']['sso_appname'] = 'jira'
default['jira']['crowd_sso']['sso_password'] = 'jira'
default['jira']['crowd_sso']['crowd_base_url'] = 'http://localhost:8095/crowd/'
