require 'spec_helper'
require 'integration/models/test_model'
require 'integration/models/migrated_model'

describe DataMapper::Is::Predefined do
  before(:all) do
    TestModel.auto_migrate!
  end

  context "migrations" do
    it "should extend MigrationMethods, if Migrations are included" do
      TestModel.should_not be_kind_of(DataMapper::Is::Predefined::MigrationMethods)
      MigratedModel.should be_kind_of(DataMapper::Is::Predefined::MigrationMethods)
    end

    it "should create all predefined resources after auto_migrate!" do
      MigratedModel.auto_migrate!

      resources = MigratedModel.all

      resources[0].id.should == 1
      resources[0].name.should == 'test1'

      resources[1].id.should == 2
      resources[1].name.should == 'test2'
    end

    it "should create missing predefined resources after auto_upgrade!" do
      MigratedModel.first(:name => 'test2').destroy!

      MigratedModel.property :extra, String
      MigratedModel.auto_upgrade!

      resources = MigratedModel.all

      resources[0].id.should == 1
      resources[0].name.should == 'test1'

      resources[1].id.should == 3
      resources[1].name.should == 'test2'
    end
  end

  it "should define the @predefined_attributes instance variable" do
    TestModel.should be_instance_variable_defined(:@predefined_attributes)
  end

  it "should provide the names of all predefined resources of a Model" do
    TestModel.predefined.should =~ [:test1, :test2]
  end

  it "should determine if a predefined resource was defined" do
    TestModel.should be_predefined(:test2)
  end

  it "should be able to define resources of a Model" do
    test1 = TestModel.test1

    test1.should_not be_nil
    test1.name.should == 'test1'
    test1.number.should == 1
    test1.optional.should == 'yo'
    test1.body.should == %{This is a test.}
  end

  it "should be able to define resources with missing attributes" do
    test2 = TestModel.test2

    test2.should_not be_nil
    test2.name.should == 'test2'
    test2.number.should == 2
    test2.optional.should == 'hello'
    test2.body.should be_nil
  end

  it "should return existing resources" do
    first_test1 = TestModel.test1
    second_test1 = TestModel.test1

    first_test1.id.should == second_test1.id
  end

  describe "predefined_resource" do
    it "should provide a generic interface for accessing resources" do
      test1 = TestModel.predefined_resource(:test1)

      test1.name.should == 'test1'
      test1.number.should == 1
    end

    it "should raise UnknownResource when accessing undefined resources" do
      lambda {
        TestModel.predefined_resource(:missing_test)
      }.should raise_error(DataMapper::Is::Predefined::UnknownResource)
    end
  end

  describe "first_or_predefined" do
    it "should find resources based on attributes they share" do
      test2 = TestModel.first_or_predefined(:name => 'test2', :number => 2)

      test2.name.should == 'test2'
    end

    it "should allow specifying different query and predefined attributes" do
      test2 = TestModel.first_or_predefined(
        {:name.like => '%test2%'},
        {:name => 'test2', :number => 2}
      )

      test2.name.should == 'test2'
    end

    it "should return nil if no resource shares any attribute values" do
      resource = TestModel.first_or_predefined(:number => 100, :optional => 'bla')
      
      resource.should be_nil
    end
  end

  describe "predefined_resource_with" do
    it "should raise UnknownResource if no resource shares any attribute values" do
      lambda {
        TestModel.predefined_resource_with(:number => 100, :optional => 'bla')
      }.should raise_error(DataMapper::Is::Predefined::UnknownResource)
    end
  end
end
