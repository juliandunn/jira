name             'jira'
maintainer       'Julian C. Dunn'
maintainer_email 'jdunn@chef.io'
license          'Apache 2.0'
description      'Installs/Configures jira'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'

%w(redhat centos scientific oracle amazon).each do |os|
  supports os
end
