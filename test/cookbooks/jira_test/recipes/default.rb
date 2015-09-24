include_recipe 'apt::default' if platform_family?('debian')
include_recipe 'jira::server'
include_recipe 'jira::local_database'

package 'curl'
