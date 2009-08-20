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
      @deck.should be_uniq
    end
  end
  
  it "has 104 cards when 2 is passed" do
    deck = Deck.new(:number_of_decks => 2)
    deck.size.should == 104
  end

end