require 'spec_helper'
require 'integration/models/test_model'

if (HAS_SQLITE3 || HAS_MYSQL || HAS_POSTGRES)
  describe DataMapper::Predefined do
    before(:all) do
      TestModel.auto_migrate!
    end

    it "should be able to define resources of a Model" do
      test1 = TestModel.test1

      test1.should_not be_nil
      test1.name.should == 'test1'
      test1.number.should == 1
      test1.optional.should == 'yo'
      test1.body.should == %{This is a test.}
    end

    it "should be able to define resources with empty attributes" do
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

    it "should provide a generic interface for accessing resources" do
      test1 = TestModel.predefined_resource(:test1)

      test1.name.should == 'test1'
      test1.number.should == 1
    end

    it "should raise an UnknownResource exception when accessing undefined resources" do
      lambda {
        TestModel.predefined_resource(:test3)
      }.should raise_error(DataMapper::Predefined::UnknownResource)
    end
  end
end
