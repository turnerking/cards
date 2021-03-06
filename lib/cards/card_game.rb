require File.expand_path(File.dirname(__FILE__) + '/deck')

class CardGame
  
  attr_accessor :deck, :with_output
  
  def initialize(options = {})
    @deck = Deck.new(options)
    @with_output = options[:with_output] || true
  end

  protected

  def game_event(message)
    puts message if with_output
  end
  
end
