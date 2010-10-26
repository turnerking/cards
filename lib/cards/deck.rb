require File.expand_path(File.dirname(__FILE__) + '/card_collection')

class Deck < CardCollection
  def initialize(options = {})
    create_decks(options)
  end
  
  def give_card_to(player)
    player.hand << shift
  end
  
private

  def create_decks(options)
    (options[:number_of_decks] || 1).times do
      range(options).each do |rank|
        ["♥", "♦", "♣", "♠"].each do |suit|
          self.push(Card.new(:rank => rank, :suit => suit))
        end
      end
    end
  end
  
  def range(options)
    options[:aces_high] ? (2..14) : (1..13)
  end

end