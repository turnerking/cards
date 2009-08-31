require File.expand_path(File.dirname(__FILE__) + '/deck')

class CardGame
  
  attr_accessor :deck
  
  def initialize(options = {})
    @deck = Deck.new(options)
    @deck.shuffle!
  end
  
end