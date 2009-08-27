require File.expand_path(File.dirname(__FILE__) + '/multiplayer_card_game')

class War < MultiplayerCardGame
  
  attr_accessor :played_cards, :pot
  
  def initialize
    super(:number_of_decks => 1, :aces_high => true)
    @deck.shuffle!
    create_players(2, false)
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
      @pot = []
      @played_cards = []
      round
    end
    @players.each do |player|
      puts player.player_no.to_s + ": " + player.hand.size.to_s
    end
  end
  
  def round
    players_play_cards(@played_cards)
    display_battle
    winners_index = determine_winner
    add_played_cards_to_pot
    return give_cards_to_player(@pot, @players[winners_index]) unless winners_index == -1
    go_to_war
  end
  
  def go_to_war
    puts "WAR!!!"
    @played_cards = []
    3.times { players_play_cards(@pot) }
    round
  end
  
  def players_play_cards(collection)
    @players.each {|player| collection << player.play_top_card}
  end
  
  def determine_winner
    max_number = @played_cards.map{|card| card ? card.rank : 0 }.max
    number_of_cards_with(max_number) > 1 ? -1 : player_with(max_number)
  end
  
  def give_cards_to_player(pot, player)
    player.receive_cards(pot)
  end
  
  def everyone_has_cards
    @players.each do |player|
      return false if player.hand.empty?
    end
    true
  end
  
private
  def display_battle
    @played_cards.each_with_index do |card, index|
      puts "Player #{index + 1}: #{card}"
    end
  end

  def add_played_cards_to_pot
    @pot << @played_cards
    @pot.flatten!.compact!
  end
  
  def number_of_cards_with(rank)
    @played_cards.map {|card| !card.nil? && card.rank == rank ? 1 : nil}.compact.size
  end
  
  def player_with(rank)
    @played_cards.index{|card| !card.nil? && card.rank == rank}
  end
  
end

w = War.new
w.deal_initial_cards
w.play