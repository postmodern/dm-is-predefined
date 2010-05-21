require 'dm-core'
require 'dm-is-predefined/is/predefined'

DataMapper::Model.append_extensions DataMapper::Is::Predefined
