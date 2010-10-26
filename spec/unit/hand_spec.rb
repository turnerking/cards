require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hand do
  it "is a CardCollection" do
    Hand.new.should be_a CardCollection
  end
end