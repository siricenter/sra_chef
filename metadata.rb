name             'sra_chef'
maintainer       'Siri'
maintainer_email 'CJPoll@gmail.com'
license          'All rights reserved'
description      'Installs/Configures sra'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.19'

depends 'git'

provides "sra::default"
provides "sra::production"

supports 'debian', '>= 7.0' 
