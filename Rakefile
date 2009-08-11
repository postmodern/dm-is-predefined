# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'
require './tasks/spec.rb'
require './tasks/yard.rb'
require './lib/dm-predefined/version.rb'

Hoe.spec('dm-predefined') do
  self.rubyforge_name = 'dm-predefined'
  self.developer('Postmodern','postmodern.mod3@gmail.com')
  self.remote_rdoc_dir = ''
  self.extra_deps = [
    ['yard', '>=0.2.3.4'],
    ['dm-core', '>=0.10.0']
  ]
end

# vim: syntax=Ruby
