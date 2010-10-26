require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'war/war'

describe War do

  it "creates two players" do
    w = War.new
    w.players.size.should == 2
    w.players.each {|player| player.should be_a Player}
    w.deck.size.should == 52
    w.deck.each {|card| card.should be_a Card }
  end
  
  it "gives each player 26 cards" do
    w = War.new
    w.deal_initial_cards
    w.players.each {|player| player.hand.size.should == 26}
  end

end
