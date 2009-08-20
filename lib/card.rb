class Card
	attr_accessor :rank, :suit

	def initialize(attrs = {})
		@rank = attrs[:rank] || 0
		@suit = attrs[:suit] || "C"
	end
	
	def to_s
	  "#{display_rank}#{@suit}"
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
end
