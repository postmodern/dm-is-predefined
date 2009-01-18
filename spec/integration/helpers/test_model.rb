class TestModel

  include DataMapper::Resource
  include DataMapper::Predefined

  # Name property to test String values
  property :name, String

  # Number property to test Integer values
  property :number, Integer

  # Optional property to test default values
  property :optional, String, :default => 'hello'

  # Body property to test Text values
  property :body, Text

  define :test1, :name => 'test1',
    :number => 1,
    :optional => 'yo',
    :body => %{This is a test.}

  define :test2, :name => 'test2', :number => 2

end
