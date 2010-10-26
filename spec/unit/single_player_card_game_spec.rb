require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SinglePlayerCardGame do
  it "is a CardGame" do
    SinglePlayerCardGame.new.should be_a CardGame
  end
end