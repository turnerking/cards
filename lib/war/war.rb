require File.expand_path(File.dirname(__FILE__) + '/../cards/multiplayer_card_game')

class War < MultiplayerCardGame
  
  attr_accessor :played_cards, :pot
  
  def initialize(options = {})
    super({:number_of_decks => 1, :aces_high => true}.merge(options))
    @deck.shuffle!
    create_players(2, false)
  end
  
  def play
    while everyone_has_cards
      @pot = []
      @played_cards = []
      round
      @players.each do |player|
        game_event "#{player.player_no}: #{player.hand.size.to_s}"
      end
    end
  end
  
  def round
    players_play_cards(@played_cards)
    winners_index = determine_winner
    add_played_cards_to_pot
    return give_cards_to_player(@pot, @players[winners_index]) unless winners_index == -1
    go_to_war
  end
  
  def go_to_war
    game_event "WAR!!!"
    @played_cards = []
    3.times { players_play_cards(@pot, true) }
    round
  end
  
  def players_play_cards(collection, pot = false)
    @players.each do |player| 
      played_card = player.play_top_card 
      collection << played_card
      game_event "#{player}: #{played_card}" unless pot
    end
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
