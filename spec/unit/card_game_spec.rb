require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CardGame do

  it "grabs a deck of cards" do
    game = CardGame.new
    game.deck.should be_a Deck
    game.deck.size.should == 52
  end

end