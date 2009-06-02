# Needed to import datamapper and other gems
require 'rubygems'
require 'pathname'

# Add all external dependencies for the plugin here
gem 'dm-core', '~>0.10.0'
require 'dm-core'

# Require plugin-files
require Pathname(__FILE__).dirname.expand_path / 'dm-predefined' / 'predefined.rb'


# Include the plugin in Resource
module DataMapper
  module Resource
    module ClassMethods
      include DataMapper::Predefined
    end # module ClassMethods
  end # module Resource
end # module DataMapper
