require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Player do
  before :each do
    @player = Player.new
    @player.hand = [Card.new(:rank => 1), Card.new(:rank => 2)]  
  end
  
  it "shifts the top card off the hand" do
    first_card = @player.hand.first
    @player.play_top_card.should == first_card
  end
  
  it "receives cards and has a single dimensional array of cards" do
    @player.receive_cards([Card.new(:rank => 3), Card.new(:rank => 4)])
    @player.hand.size.should == 4
    @player.hand.each {|card| card.should be_a Card}
  end
end