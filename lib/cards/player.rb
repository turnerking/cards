require File.expand_path(File.dirname(__FILE__) + '/hand')

class Player

  attr_accessor :hand, :player_no, :is_human
  
  def initialize(attrs = {})
    @hand = Hand.new
    @player_no = attrs[:player_no] || 0
    @is_human = attrs[:is_human] || false
  end

  def to_s
    "Player #{player_no}"
  end
  
  def play_top_card
    @hand.shift
  end
  
  def receive_cards(cards)
    @hand << cards
    @hand.flatten! 
  end

end
