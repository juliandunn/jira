#
# JIRA installation
#

install_bin = "#{Chef::Config[:file_cache_path]}/atlassian-jira-install.bin"
install_var = "#{Chef::Config[:file_cache_path]}/atlassian-jira-install.varfile"

# Download JIRA install
remote_file install_bin do
  source   node['jira']['url']
  checksum node['jira']['checksum']
  mode     '0755'
end

# Create response varfile
#
# *note: install4j will not register all variables as response variables, so
# althought the installer will process everything fine, it will not write all
# variables into the final .instal4j/response.varfile in the install dir.
#
template install_var do # ~FC033
  source   'generic/properties.erb'
  mode     '0644'
  variables(properties: node['jira']['install'])
end

# Execute install
execute 'install' do
  command "#{install_bin} -q -varfile #{install_var}"
  creates node['jira']['install']['sys.installationDir']
end

# Set up additional JAR libraries
if node['jira']['lib']
  node['jira']['lib'].each do |name, conf|
    remote_file name do
      source conf['source']
      path   conf['path']
    end
  end
end
