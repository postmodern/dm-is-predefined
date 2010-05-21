require 'spec_helper'
require 'integration/models/test_model'

if (HAS_SQLITE3 || HAS_MYSQL || HAS_POSTGRES)
  describe DataMapper::Predefined do
    before(:all) do
      TestModel.auto_migrate!
    end

    it "should define the @predefined_attributes instance variable" do
      TestModel.should be_instance_variable_defined(:@predefined_attributes)
    end

    it "should provide the names of all predefined resources of a Model" do
      TestModel.predefined_names.should =~ [:test1, :test2]
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
        }.should raise_error(DataMapper::Predefined::UnknownResource)
      end
    end

    describe "predefined_resource_with" do
      it "should find resources based on attributes they share" do
        test2 = TestModel.predefined_resource_with(:name => 'test2', :number => 2)

        test2.name.should == 'test2'
      end

      it "should raise UnknownResource if no resource shares all attribute names" do
        lambda {
          TestModel.predefined_resource_with(:number => 1, :missing => 'yo')
        }.should raise_error(DataMapper::Predefined::UnknownResource)
      end

      it "should raise UnknownResource if no resource shares any attribute names" do
        lambda {
          TestModel.predefined_resource_with(:missing => 1, :typo => 'yo')
        }.should raise_error(DataMapper::Predefined::UnknownResource)
      end

      it "should raise UnknownResource if no resource shares all attribute values" do
        lambda {
          TestModel.predefined_resource_with(:number => 2, :optional => 'yo')
        }.should raise_error(DataMapper::Predefined::UnknownResource)
      end

      it "should raise UnknownResource if no resource shares any attribute values" do
        lambda {
          TestModel.predefined_resource_with(:number => 3, :optional => 'bla')
        }.should raise_error(DataMapper::Predefined::UnknownResource)
      end
    end
  end
end
