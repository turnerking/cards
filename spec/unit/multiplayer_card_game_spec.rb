require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MultiplayerCardGame do

  it "has players" do
    m = MultiplayerCardGame.new
    m.create_players(2)
    m.players.should be_a Array
    m.players.first.should be_a Player
  end
  
  it "deals out all the cards" do
    m = MultiplayerCardGame.new
    m.create_players(4)
    m.deal_initial_cards
    m.players.inject(0) {|total_cards, player| total_cards + player.hand.size }.should == 52
  end
  
  it "makes sure there are no nil cards on uneven amounts" do
    m = MultiplayerCardGame.new
    m.create_players(5)
    m.deal_initial_cards
    m.players.each do |player| 
      hand = player.hand
      hand.should_not include(nil)
    end
  end
  
end

class NilClass
  def rank
    self
  end
end
