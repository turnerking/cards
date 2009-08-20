require 'card_collection'

class Deck < CardCollection
  def initialize(options = {})
    create_decks(options[:number_of_decks] || 1)
  end
  
private

  def create_decks(number_of_decks)
    number_of_decks.times do
      (1..13).each do |rank|
        ["H", "D", "C", "S"].each do |suit|
          self.push(Card.new(:rank => rank, :suit => suit))
        end
      end
    end
  end

end

Deck.new