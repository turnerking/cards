require 'multiplayer_card_game'

class War < MultiplayerCardGame
  
  attr_accessor :played_cards, :pot
  
  def initialize
    super(:number_of_decks => 1, :aces_high => true)
    @deck.shuffle!
    create_players(2, false)
    @played_cards = []
    @pot = []
  end
  
  def deal_initial_cards
    while !@deck.empty? do
      @players.each do |player|
        @deck.give_card_to(player)
      end
    end
  end
  
  def play
    while everyone_has_cards
      round
    end
    @players.each do |player|
      puts player.hand.size
    end
  end
  
  def round
    players_play_cards(@played_cards)
    winners_index = determine_winner
    return give_cards_to_player(@pot, @players[winners_index]) unless winners_index == -1
    go_to_war
  end
  
  def go_to_war
    @pot << @played_cards
    @played_cards.clear
    3.times { players_play_cards(@pot) }
    play
  end
  
  def players_play_cards(collection)
    @players.each {|player| collection << player.play_top_card}
  end
  
  def determine_winner
    max_number = @played_cards.max
    @played_cards.map {|card| card.rank == max_number}.compact.size > 1 ? -1 : @played_cards.index(max_number)
  end
  
  def give_cards_to_player(pot, player)
    player.receive_cards(pot)
  end
  
  def everyone_has_cards
    @players.each do |player|
      return false if player.hand.empty?
    end
    return true
  end
  
end

w = War.new
w.deal_initial_cards
w.play