require 'dm-is-predefined'

class MigratedModel

  include DataMapper::Resource
  include DataMapper::Migrations

  is :predefined

  # Primary key of the test model
  property :id, Serial

  # Name property to test String values
  property :name, String

  predefine :test1, :name => 'test1'
  predefine :test2, :name => 'test2'

end
