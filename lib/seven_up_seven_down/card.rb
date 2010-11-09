class Card
  def same_as?(card)
    @rank == card.rank && @suit == card.suit
  end
end
