require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CardCollection do
  it "is an Array" do
    CardCollection.new.should be_a Array
  end
end
