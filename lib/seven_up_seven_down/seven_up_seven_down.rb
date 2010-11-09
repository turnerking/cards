class SevenUpSevenDown < MultiplayerCardGame
  
  attr_accessor :played_hearts, :played_spades, :played_clubs, :played_diamonds, :place_playing_for, :playable_cards
  
  def initialize
    super(:number_of_decks => 1)
    @deck.shuffle!
    create_players(13, false)
    create_played_collections
    initial_playable_cards
    @place_playing_for = 1
  end
  
  def play
    while someone_has_cards do
      @players.each do |player|
        next if player.hand.empty?
        puts "#{player} starts turn".center(40, "~")
        available_cards = available_cards_to(player)
        if !available_cards.empty?
          card_to_play = choose_card_from(available_cards)
          play_card(card_to_play, player)
          print_table
          if player.hand.empty?
            puts "#{player} finished #{place_playing_for.ordinal}"
            @place_playing_for = place_playing_for.next
          end
        else
          puts "#{player} passed"
          print_table
        end
        puts "#{player} finished turn".center(40, "^") + "\n\n"
      end
    end
  end

  def play_card(played_card, player)
    add_played_card(played_card)
    player.hand.delete_if {|card| card.same_as?(played_card) }
    puts "#{player} played #{played_card}"
  end

  def available_cards_to(player)
    cards_able_to_play = @playable_cards.map(&:to_splittable_s) & player.hand.map(&:to_splittable_s)
    cards_able_to_play.map do |card_string| 
      rank, suit = card_string.split(":")
      Card.new(:rank => rank.to_i, :suit => suit)
    end
  end

  def add_played_card(card)
    send("played_#{card.suit_to_word}s") << card
    update_playable_cards(card)
  end

  private

  def update_playable_cards(card)
    playable_cards.delete_if {|c| c.same_as?(card)}
    case
    when card.rank == 7
      playable_cards << Card.new(:rank => 8, :suit => card.suit)
      playable_cards << Card.new(:rank => 6, :suit => card.suit)
    when (8..12).include?(card.rank)
      playable_cards << Card.new(:rank => (card.rank + 1), :suit => card.suit)
    when (2..6).include?(card.rank)
      playable_cards << Card.new(:rank => (card.rank - 1), :suit => card.suit)
    else
      # Playing an ace or a king
    end
  end

  def choose_card_from(available_cards)
    available_cards.first
  end

  def someone_has_cards
    someone_has_cards = false
    @players.each do |player|
      someone_has_cards = true unless player.hand.empty?
    end
    someone_has_cards
  end

  def print_table
    played_collections_array.each do |played_cards|
      string = ""
      unless played_cards.empty?
        (played_cards.sort.first.rank - 1).times { string += "   " }
      end

      puts (string + played_cards.sort.join(" "))
    end
  end

  def create_played_collections
    @played_hearts = CardCollection.new
    @played_spades = CardCollection.new
    @played_clubs = CardCollection.new
    @played_diamonds = CardCollection.new
  end

  def initial_playable_cards
    @playable_cards = []
    ["♥", "♦", "♣", "♠"].each do |suit|
      playable_cards << Card.new(:rank => 7, :suit => suit)
    end
  end

  def played_collections_array
    [@played_hearts, @played_spades, @played_clubs, @played_diamonds]
  end
end
