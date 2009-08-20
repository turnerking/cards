require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MultiplayerCardGame do

  it "has hands" do
    m = MultiplayerCardGame.new
    m.hands.should be_a Array
    m.hands.first.should be_a Hand
  end

end