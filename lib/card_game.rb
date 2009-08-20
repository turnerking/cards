require 'deck'

class CardGame
  
  attr_accessor :deck
  
  def initialize
    @deck = Deck.new
  end
  
end