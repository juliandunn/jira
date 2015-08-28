name 'jira'
maintainer 'Julian C. Dunn'
maintainer_email 'jdunn@chef.io'
license 'Apache 2.0'
description 'Installs/Configures jira'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.4'

depends 'database'
depends 'iptables'
depends 'java'
depends 'openssl', '~> 4.0.0'
depends 'postgresql', '~> 3.4.20'

%w(redhat centos scientific oracle amazon debian ubuntu).each do |os|
  supports os
end
