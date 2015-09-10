#
# JIRA configuration
#

# Create database configuration XML
template "#{node['jira']['install']['app.jiraHome']}/dbconfig.xml" do # ~FC033
  source   'generic/xml.erb'
  mode     '0644'
  notifies :restart, 'service[jira]'
  variables(hash: node['jira']['dbconfig'])
end
