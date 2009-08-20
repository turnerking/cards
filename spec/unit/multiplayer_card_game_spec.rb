require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MultiplayerCardGame do

  it "has players" do
    m = MultiplayerCardGame.new
    m.create_players(2)
    m.players.should be_a Array
    m.players.first.should be_a Player
  end

end