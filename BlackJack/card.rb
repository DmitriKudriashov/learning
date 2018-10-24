# card.rb
class Card
  include Accessors

  attr_reader :nominal, :suit, :cost, :name, :lookup

  def initialize(nominal, suit, cost)
    @nominal = nominal
    @suit = suit
    @cost = cost
    @name = nominal + suit
    @lookup = false
  end

  def open!
    self.lookup = true
  end

  def open?
    lookup
  end

  private

  attr_writer :lookup
end
