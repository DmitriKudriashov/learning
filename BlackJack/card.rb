# card.rb
class Card
  include Accessors

  attr_accessor_with_history :cost, :nominal, :suit, :name, :lookup

  def initialize(nominal, suit, cost)
    @nominal = nominal
    @suit = suit
    @cost = cost
    @name = nominal + suit
    hide!
  end

  def open!
    self.lookup = true
  end

  def hide!
    self.lookup = false
  end

  def open?
    self.lookup
  end
end
