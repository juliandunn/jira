include_recipe 'jira::install'
include_recipe 'jira::configure'

service 'jira' do
  supports restart: false, reload: false, status: false
end
