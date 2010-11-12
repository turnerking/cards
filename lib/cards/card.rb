class Card
  include Comparable
	attr_accessor :rank, :suit

	def initialize(attrs = {})
		@rank = attrs[:rank] || 0
		@suit = attrs[:suit] || "♣"
	end

  def suit_to_word
    {"♥" => "heart",
     "♦" => "diamond",
     "♣" => "club",
     "♠" => "spade"
    }[@suit]
  end

  RANK_TO_WORD_HASH =
    { "A" => "ace",
      "2" => "two",
      "3" => "three",
      "4" => "four",
      "5" => "five",
      "6" => "six",
      "7" => "seven",
      "8" => "eight",
      "9" => "nine",
      "10" => "ten",
      "J" => "jack",
      "Q" => "queen",
      "K" => "king",
    }

  def rank_to_word
    RANK_TO_WORD_HASH[display_rank]
  end
	
	def to_s
	  "#{display_rank}#{@suit}"
	end
	
	def to_splittable_s
	  "#{@rank}:#{@suit}"
	end
	
	def display_rank
	  if @rank == 1 || @rank == 14
	    "A"
	  elsif @rank > 1 && @rank < 11
	    @rank.to_s
	  elsif @rank == 11
	    "J"
	  elsif @rank == 12
	    "Q"
	  elsif @rank == 13
	    "K"
    else
      raise "Well what are you then? (#{@rank})"
    end
	end
	
	def <=>(card)
    @rank <=> card.rank
  end

  def same_as?(card)
    @rank == card.rank && @suit == card.suit
  end

  RANK_TO_WORD_HASH.each do |rank, word|
    define_method("#{word}?".to_sym) do
      display_rank == rank
    end
  end
end
