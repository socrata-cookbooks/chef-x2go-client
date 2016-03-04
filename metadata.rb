# Encoding: UTF-8

name             'x2go-client'
maintainer       'Jonathan Hartman'
maintainer_email 'jonathan.hartman@socrata.com'
license          'apache2'
description      'Installs/Configures x2go-client'
long_description 'Installs/Configures x2go-client'
version          '1.0.0'

depends          'xquartz', '~> 1.1'
depends          'dmg', '~> 2.2'
depends          'windows', '~> 1.38'
depends          'apt', '~> 3.0'
depends          'yum-epel', '~> 0.6'

supports         'mac_os_x'
supports         'windows'
supports         'ubuntu'
supports         'debian'
supports         'redhat'
supports         'centos'
supports         'scientific'
supports         'fedora'
