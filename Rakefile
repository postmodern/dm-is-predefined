# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'
require './tasks/yard.rb'

Hoe.spec('dm-predefined') do
  self.rubyforge_name = 'dm-predefined'
  self.developer('Postmodern','postmodern.mod3@gmail.com')

  self.remote_rdoc_dir = ''

  self.rspec_options += ['--colour', '--format', 'specdoc']

  self.extra_deps = [
    ['yard', '>=0.2.3.5'],
    ['dm-core', '>=0.10.0']
  ]

  self.extra_dev_deps = [
    ['rspec', '>=1.2.9']
  ]

  self.spec_extras = {:has_rdoc => 'yard'}
end

# vim: syntax=Ruby
