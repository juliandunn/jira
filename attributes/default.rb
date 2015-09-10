#
# JIRA installer configuration
#

default['jira']['version']  = '6.4.11'
default['jira']['url']      = "https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-#{node['jira']['version']}-x64.bin"
default['jira']['checksum'] = '4030010efd5fbec3735dc3a585cd833af957cf7efe4f4bbc34b17175ff9ba328'

# This will get transformed into a response.varfile for the installer
default['jira']['install']['rmiPort$Long']                          = '8005'
default['jira']['install']['app.jiraHome']                          = '/var/atlassian/application-data/jira'
default['jira']['install']['app.install.service$Boolean']           = 'true'
default['jira']['install']['existingInstallationDir']               = '/opt/jira'
default['jira']['install']['sys.confirmedUpdateInstallationString'] = 'false'
default['jira']['install']['sys.languageId']                        = 'en'
default['jira']['install']['sys.installationDir']                   = '/opt/atlassian/jira'
default['jira']['install']['executeLauncherAction$Boolean']         = 'true'
default['jira']['install']['httpPort$Long']                         = '8080'
default['jira']['install']['portChoice']                            = 'default'

# # Additional libraries to add
# # example: MySQL connector for JIRA
# default['jira']['lib']['mysql-connector']['source'] = 'http://www.example.com/mysql-connector.jar'
# default['jira']['lib']['mysql-connector']['path']   = "#{node['jira']['install']['sys.installationDir']}/lib/mysql-connector.jar"

#
# JIRA database configuration
#

default['jira']['dbconfig']['jira-database-config']['name']           = 'defaultDS'
default['jira']['dbconfig']['jira-database-config']['delegator-name'] = 'default'
default['jira']['dbconfig']['jira-database-config']['database-type']  = 'hsql'
default['jira']['dbconfig']['jira-database-config']['schema-name']    = 'public'

default['jira']['dbconfig']['jira-database-config']['jdbc-datasource']['url']          = "jdbc:hsqldb:#{node['jira']['install']['app.jiraHome']}/database/jiradb"
default['jira']['dbconfig']['jira-database-config']['jdbc-datasource']['driver-class'] = 'org.hsqldb.jdbcDriver'
default['jira']['dbconfig']['jira-database-config']['jdbc-datasource']['username']     = 'sa'
default['jira']['dbconfig']['jira-database-config']['jdbc-datasource']['password']     = ''
