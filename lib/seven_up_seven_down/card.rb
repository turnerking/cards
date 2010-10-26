class Card
  def ==(card)
    @rank == card.rank && @suit == card.suit
  end
end
