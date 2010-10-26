require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Card do

  it "creates a card based on attributes passed in" do
    card = Card.new(:rank => 4, :suit => 'S')
    card.rank.should == 4
    card.suit.should == 'S'
  end
  
  it "equals another card when they both have the same rank" do
    first_card = Card.new(:rank => 6, :suit => 'H')
    second_card = Card.new(:rank => 6, :suit => 'D')
    first_card.should == second_card
  end
  
  it "is greater than another card when it has a higher rank" do
    first_card = Card.new(:rank => 7, :suit => 'H')
    second_card = Card.new(:rank => 6, :suit => 'D')
    first_card.should > second_card
  end
  
  it "is less than another card when it has a lower rank" do
    first_card = Card.new(:rank => 5, :suit => 'H')
    second_card = Card.new(:rank => 6, :suit => 'D')
    first_card.should < second_card
  end

  describe "to string" do
    before(:all) do
      @card = Card.new(:rank => 1, :suit => "H")
    end
    
    it "displays correct string for 1" do
      @card.to_s.should == 'AH'
    end
    
    it "displays correct string for 14" do
      @card.rank = 14
      @card.to_s.should == 'AH'
    end
    
    it "displays correct string for 13" do
      @card.rank = 13
      @card.to_s.should == 'KH'
    end
    
    it "displays correct string for 12" do
      @card.rank = 12
      @card.to_s.should == 'QH'
    end
    
    it "displays correct string for 11" do
      @card.rank = 11
      @card.to_s.should == 'JH'
    end
    
    it "displays correct string for 10" do
      @card.rank = 10
      @card.to_s.should == '10H'
    end
    
    it "displays correct string for 2 through 9" do
      (2..9).each do |r|
        @card.rank = r
        @card.to_s.should == "#{r}H"
      end
    end
  end
  
  describe "display rank" do
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
