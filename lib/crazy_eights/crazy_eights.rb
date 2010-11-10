class CrazyEights < MultiplayerCardGame
  attr_accessor :starting_no_of_cards, :discard_pile, :place_playing_for

  def initialize
    super(:number_of_decks => 1)
    @starting_no_of_cards = 5
    @discard_pile = CardCollection.new
    @deck.shuffle!
    create_players(4, false)
    @discard_pile << @deck.shift
    @place_playing_for = 1
  end

  def play
    while someone_has_cards do
      @players.each do |player|
        next if player.hand.empty?
        puts "#{player} starts turn".center(40, "~")
        puts "Top card is #{@discard_pile.last}"
        puts "Player's hand: #{player.hand.join(" ")}"
        while available_cards_to(player).empty?
          @deck.give_card_to(player)
          puts "#{player} draws a card"
          puts "Player's hand: #{player.hand.join(" ")}"
          puts "Deck size is #{@deck.size}"
          puts "Discard pile size is #{@discard_pile.size}"
          if @deck.empty?
            top_card = @discard_pile.last
            @deck << @discard_pile[0..-2]
            @deck.flatten!
            @deck.shuffle!
            @discard_pile = CardCollection.new
            @discard_pile << top_card
            puts "Shuffling Discard into deck"
            puts "Discard pile size is #{@discard_pile.size}"
            puts "Deck size is #{@deck.size}"
          end
        end
        play_card(available_cards_to(player).first, player)
        if player.hand.empty?
          puts "#{player} finished #{place_playing_for.ordinal}"
          @place_playing_for = place_playing_for.next
        end
        puts "#{player} finished turn".center(40, "^") + "\n\n"
      end
    end
  end

  def play_card(played_card, player)
    @discard_pile.push(played_card)
    player.hand.delete_if {|card| card.same_as?(played_card) }
    puts "#{player} played #{played_card}"
  end
  
  def available_cards_to(player)
    cards_able_to_play = playable_cards.map(&:to_splittable_s) & player.hand.map(&:to_splittable_s)
    cards_able_to_play.map do |card_string| 
      rank, suit = card_string.split(":")
      Card.new(:rank => rank.to_i, :suit => suit)
    end
  end

  def playable_cards
    top_card = @discard_pile.last
    playable_cards = []
    ((1..13).to_a - [top_card.rank]).each do |rank|
      playable_cards << Card.new(:rank => rank, :suit => top_card.suit)
    end
    (["♥", "♦", "♣", "♠"] - [top_card.suit]).each do |suit|
      playable_cards << Card.new(:rank => top_card.rank, :suit => suit)
    end
    playable_cards
  end

  def deal_initial_cards
    starting_no_of_cards.times do
      @players.each do |player|
        break if @deck.empty?
        @deck.give_card_to(player)
      end
    end
  end

  private
  
  def someone_has_cards
    someone_has_cards = false
    @players.each do |player|
      someone_has_cards = true unless player.hand.empty?
    end
    someone_has_cards
  end
end
