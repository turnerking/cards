require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Card do

  describe "card value" do
    before(:all) do
      @card = Card.new(:rank => 1, :suit => "H")
    end
    
    it "returns A when 1" do
      @card.display_rank.should == 'A'
    end
    
    it "returns A when 14" do
      @card.rank = 14
      @card.display_rank.should == 'A'
    end
    
    it "returns K when 13" do
      @card.rank = 13
      @card.display_rank.should == 'K'
    end
    
    it "returns Q when 12" do
      @card.rank = 12
      @card.display_rank.should == 'Q'
    end
    
    it "returns J when 11" do
      @card.rank = 11
      @card.display_rank.should == 'J'
    end
    
    it "returns value when between 2 and 10" do
      (2..10).each do |r|
        @card.rank = r
        @card.display_rank.should == r.to_s
      end
    end
  end

end