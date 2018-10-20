# box.rb - ящик из которого диллер достает карты
class CardsBox
  include Accessors

  attr_accessor_with_history :box, :cards

  def initialize
    @cards = []
    create_deck_cards
    3.times { @cards.shuffle! } # перемешать карты 3 раза!
  end

  def cards_total
    cards.count
  end

  def create_deck_cards
    ['<3', '<>','^', '+'].each do |suit|
      (2..10).each { |value| @cards << Card.new(value.to_s, suit, value)}
      ['V', 'D', 'K'].each { |value| @cards << Card.new(value, suit, 10)}
      @cards << Card.new('A', suit, 1)
    end
  end

  def give_out
    current_card = @cards.first
    @cards -= [current_card]
    current_card
  end

  def list_box
    cards.each{ |card| puts "Card name: #{card.name}, nominal: #{card.nominal}, suit: #{card.suit} cost: #{card.cost}  "}
  end

end

