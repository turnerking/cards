class SevenUpSevenDown < MultiplayerCardGame
  
  attr_accessor :played_hearts, :played_spades, :played_clubs, :played_diamonds
  
  def initialize
    super(:number_of_decks => 1)
    @deck.shuffle!
    create_players(4, false)
    @played_hearts = CardCollection.new
    @played_spades = CardCollection.new
    @played_clubs = CardCollection.new
    @played_diamonds = CardCollection.new
  end
  
  def play
    while someone_has_cards do
      @players.each do |player|
        available_cards = playable_cards & player.hand
        if !available_cards.empty?
          add_played_card(available_cards.first)
          player.hand.delete(available_cards.first)
        end
      end
    end
  end

  def playable_cards
    cards_to_play = []
    [[@played_hearts, "♥"], [@played_spades, "♠"], [@played_clubs, "♣"], [@played_diamonds, "♦"]].each do |played_cards_in_suit, suit|
      if played_cards_in_suit.empty?
        cards_to_play << Card.new(:rank => 7, :suit => suit)
      else
        lowest_played = played_cards_in_suit.min.rank
        highest_played = played_cards_in_suit.max.rank

        cards_to_play << Card.new(:rank => (lowest_played - 1), :suit => suit) unless lowest_played == 1
        cards_to_play << Card.new(:rank => (highest_played + 1), :suit => suit) unless highest_played == 13
      end
    end
    cards_to_play
  end

  def someone_has_cards
    someone_has_cards = false
    @players.each do |player|
      someone_has_cards = true unless player.hand.empty?
    end
    someone_has_cards
  end
end

# Standard Input
# print("Enter number of players: ")
# $stdout.flush
# input = gets
