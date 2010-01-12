# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'

Hoe.plugin :yard

Hoe.spec('dm-predefined') do
  self.rubyforge_name = 'dm-predefined'
  self.developer('Postmodern','postmodern.mod3@gmail.com')

  self.rspec_options += ['--colour', '--format', 'specdoc']

  self.yard_opts += ['--protected']
  self.remote_rdoc_dir = ''

  self.extra_deps += [
    ['dm-core', '>=0.10.2']
  ]

  self.extra_dev_deps += [
    ['rspec', '>=1.2.9']
  ]
end

# vim: syntax=Ruby
