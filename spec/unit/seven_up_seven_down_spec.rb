require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'seven_up_seven_down/seven_up_seven_down'

describe SevenUpSevenDown do
  before :each do
    @game = SevenUpSevenDown.new
  end
  
  describe "setup" do
  
    it "is a MultiplayerCardGame" do
      @game.should be_a MultiplayerCardGame
    end
  
    it "creates a deck with aces low" do
      @game.deck.should_not be_empty
      @game.deck.map(&:rank).should_not include 14
    end
  
    it "shuffles the deck" do
      original_deck = CardGame.new
      original_deck.should_not == @game.deck
    end
    
    it "creates a specified number of players" do
      @game.players.size.should == 4
    end
  
  end
  
  it "has sevens as the initial playable cards" do
    @game.playable_cards.size.should == 4
    @game.playable_cards.should include Card.new(:rank => 7, :suit => "♠")
    @game.playable_cards.should include Card.new(:rank => 7, :suit => "♣")
    @game.playable_cards.should include Card.new(:rank => 7, :suit => "♥")
    @game.playable_cards.should include Card.new(:rank => 7, :suit => "♦")
  end

  it "has six and eight as playable cards if the seven is in place" do
    @game.played_hearts << Card.new(:rank => 7, :suit => "♥")
    @game.playable_cards.size.should == 5
    @game.playable_cards.should include Card.new(:rank => 6, :suit =>"♥")
    @game.playable_cards.should include Card.new(:rank => 8, :suit =>"♥")
  end

  it "doesn't add cards lower than an ace or higher than a king" do
    (1..13).each do |rank|
      @game.played_hearts << Card.new(:rank => rank, :suit => "♥")
    end
    @game.playable_cards.size.should == 3
    @game.playable_cards.map(&:suit).should_not include "♥"
  end
end
