class CrazyEights < MultiplayerCardGame
  attr_accessor :starting_no_of_cards, :discard_pile, :place_playing_for, :crazy_suit
  attr_reader :crazy_number

  def initialize(options = {})
    super({:number_of_decks => 1}.merge(options))
    @starting_no_of_cards = options[:starting_no_of_cards] || 5
    @discard_pile = CardCollection.new
    @deck.shuffle!
    create_players(options[:no_of_players] || 4, false)
    @place_playing_for = 1
    @crazy_number = options[:crazy_number] || 8
  end

  def play
    @discard_pile << @deck.shift
    @crazy_suit = @discard_pile.last.suit
    while someone_has_cards do
      @players.each do |player|
        next if player.hand.empty?
        turn_for(player)
      end
    end
  end

  def turn_for(player)
    game_event "#{player} starts turn".center(40, "~")
    game_event "Top card is #{@discard_pile.last}"
    while available_cards_to(player).empty?
      replenish_deck if @deck.empty?
      @deck.give_card_to(player)
      game_event "#{player} draws a card"
    end
    play_card(available_cards_to(player).first, player)
    if player.hand.empty?
      game_event "#{player} finished #{place_playing_for.ordinal}"
      @place_playing_for = place_playing_for.next
    end
    game_event "#{player} finished turn".center(40, "^") + "\n\n"
  end

  def play_card(played_card, player)
    @discard_pile.push(played_card)
    player.hand.delete_if {|card| card.same_as?(played_card) }
    if played_card.send("#{crazy_number_to_word}?")
      @crazy_suit = choose_suit_for(player)
      game_event "CRAZY #{crazy_number_to_word.upcase}! Suit is now #{@crazy_suit}"
    else
      @crazy_suit = played_card.suit
    end
    game_event "#{player} played #{played_card}"
  end

  def replenish_deck
    top_card = @discard_pile.last
    @deck << @discard_pile[0..-2]
    @deck.flatten!
    @deck.shuffle!
    @discard_pile = CardCollection.new
    @discard_pile << top_card
    game_event "Shuffling Discard into deck"
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
    (1..13).each do |rank|
      playable_cards << Card.new(:rank => rank, :suit => crazy_suit)
    end
    ["♥", "♦", "♣", "♠"].each do |suit|
      playable_cards << Card.new(:rank => top_card.rank, :suit => suit)
    end
    ["♥", "♦", "♣", "♠"].each do |suit|
      playable_cards << Card.new(:rank => crazy_number, :suit => suit)
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

  def choose_suit_for(player)
    suit_to_return = nil
    suit_count = 0
    ["♥", "♦", "♣", "♠"].each do |suit|
      if player.hand.map(&:suit).count(suit) > suit_count
        suit_count = player.hand.map(&:suit).count(suit)
        suit_to_return = suit
      end
    end
    suit_to_return
  end

  def crazy_number_to_word
    Card::RANK_TO_WORD_HASH[crazy_number.to_s]
  end
end
