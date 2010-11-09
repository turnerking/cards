require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Deck do

  describe "for default" do
    before(:all) do
      @deck = Deck.new
    end
    
    it "has 52 cards by default" do
      @deck.size.should == 52
    end
  
    it "has unique cards by default" do
      @deck.uniq.size.should == 52
    end
  end
  
  it "has aces as the high card when the option is passed" do
    deck = Deck.new(:aces_high => true)
    deck.map(&:rank).include?(1).should be_false
    deck.map(&:rank).include?(14).should be_true
  end
  
  it "has 104 cards when 2 is passed" do
    deck = Deck.new(:number_of_decks => 2)
    deck.size.should == 104
  end
  
  it "shuffles the cards randomly" do
    deck = Deck.new
    second_deck = Deck.new
    deck.should == second_deck
    second_deck.should_not == deck.shuffle!
  end
  
  it "can give a card to a player" do
    deck = Deck.new
    player = Player.new
    deck.give_card_to(player)
    deck.size.should == 51
    player.hand.size.should == 1
  end

end
