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
end
