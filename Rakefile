# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'
require './tasks/spec.rb'
require './tasks/yard.rb'

Hoe.spec('dm-predefined') do
  self.rubyforge_name = 'dm-predefined'
  self.developer('Postmodern','postmodern.mod3@gmail.com')
  self.remote_rdoc_dir = ''
  self.extra_deps = [
    ['yard', '>=0.2.3.4'],
    ['dm-core', '>=0.10.0']
  ]

  self.extra_dev_deps = [
    ['rspec', '>=1.2.6']
  ]

  self.spec_extras = {:has_rdoc => 'yard'}
end

# vim: syntax=Ruby
