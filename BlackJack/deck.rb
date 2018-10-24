# deck.rb - колода карт
class Deck

  attr_reader :cards

  SUITES = ['<3', '<>','^', '+']
  NOMINALS = ['A','2','3','4','5','6','7','8','9', '10','V','D','K']
  VALUES = [[1,11], [2], [3], [4], [5], [6], [7], [8], [9], [10], [10], [10], [10]]

  def initialize
    @cards = []
    create_deck_cards
    3.times { @cards.shuffle! } # перемешать карты 3 раза!
  end

  def create_deck_cards
    SUITES.each do |suit|
      NOMINALS.each_with_index { |nominal, index| @cards << Card.new(nominal, suit, VALUES[index].first) }
    end
  end

  def give_out
    cards.shift
  end
end

