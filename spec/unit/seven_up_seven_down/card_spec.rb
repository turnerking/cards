require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'seven_up_seven_down'

describe Card do
  describe "seven_up_seven_down" do
    it "only equals a card if it's exactly the same card" do
      first_card = Card.new(:rank => 6, :suit => 'H')
      second_card = Card.new(:rank => 6, :suit => 'H')
      first_card.should be_same_as second_card
    end

    it "does not equal if the cards have the same rank but different suits" do
      first_card = Card.new(:rank => 6, :suit => 'H')
      second_card = Card.new(:rank => 6, :suit => 'D')
      first_card.should_not be_same_as second_card
    end
  end
end
