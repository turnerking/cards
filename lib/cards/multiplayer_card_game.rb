require File.expand_path(File.dirname(__FILE__) + '/card_game')
require File.expand_path(File.dirname(__FILE__) + '/player')

class MultiplayerCardGame < CardGame
  
  attr_accessor :players
  
  def initialize(options ={})
    @players = []
    super(options)
  end
  
  def create_players(number_of_players, humans_playing = true)
    (1..number_of_players).each do |player_no|
      @players << Player.new(:player_no => player_no, :is_human => player_no == 1 && humans_playing)
    end
  end
  
  def deal_initial_cards
    while !@deck.empty? do
      @players.each do |player|
        break if @deck.empty?
        @deck.give_card_to(player)
      end
    end
  end
  
end