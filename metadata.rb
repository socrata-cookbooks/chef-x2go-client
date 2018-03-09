# frozen_string_literal: true

name 'x2go-client'
maintainer 'Socrata Engineering'
maintainer_email 'sysadmin@socrata.com'
license 'Apache-2.0'
description 'Installs/Configures x2go-client'
long_description 'Installs/Configures x2go-client'
version '1.1.1'
chef_version '>= 12.6'

source_url 'https://github.com/socrata-cookbooks/x2go-client'
issues_url 'https://github.com/socrata-cookbooks/x2go-client/issues'

depends 'xquartz', '~> 1.1'
depends 'dmg', '< 5'
depends 'yum-epel', '< 4'

supports 'mac_os_x'
supports 'windows'
supports 'ubuntu'
supports 'debian'
supports 'redhat'
supports 'centos'
supports 'scientific'
supports 'fedora'
