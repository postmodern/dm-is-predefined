require 'dm-is-predefined'

class TestModel

  include DataMapper::Resource

  is :predefined

  # Primary key of the test model
  property :id, Serial

  # Name property to test String values
  property :name, String

  # Number property to test Integer values
  property :number, Integer

  # Optional property to test default values
  property :optional, String, :default => 'hello'

  # Body property to test Text values
  property :body, Text

  predefine :test1, :name => 'test1',
                    :number => 1,
                    :optional => 'yo',
                    :body => %{This is a test.}

  predefine :test2, :name => 'test2', :number => 2

end
