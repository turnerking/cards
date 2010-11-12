require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'crazy_eights'

describe CrazyEights do
  before :each do
    @game = CrazyEights.new
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
  end

  describe "play" do
    it "doesn't lose cards" do
      @game.deal_initial_cards
      @game.with_output = false
      @game.play
      (@game.deck.size + @game.discard_pile.size).should == 52
    end
  end
end
