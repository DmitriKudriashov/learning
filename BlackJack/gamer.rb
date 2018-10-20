# gamer.rb
class Gamer
  include Accessors
  include Validation
  include GlobalValues

  attr_accessor_with_history :sum, :step, :bank, :status
  attr_reader :name, :type, :cards, :game_number

  def initialize(options = {})
    @name = options[:name]
    @type = options[:type]
    @cards = []
    @game_number = 0
    self.step = :hide
    self.bank = 100
    validate!
  end

  def new_game_init
    @cards = []
    self.step = :hide
  end

  # # for code debug only! reserved!
  # def accept_sum=(value)
  #   self.sum = value
  # end

  def calc_sum
    amount = 0
    cards.each { |card| amount += card.cost }
    qtty_aces.times do
       break if amount + 10 > 21

       amount += 10
    end
    self.sum = amount
  end

  def qtty_aces
    cards.map(&:cost).count(1)
  end

  def get_card(card)
    get
    @cards << card
    calc_sum
  end

  def bet
    self.step = :bet
    change_bank(-10)
    return 0 if self.step == :game_over
    @game_number += 1
    10
  end

  def bet_return
    change_bank(10)
  end

  def change_bank(value)
    if self.bank < -value
      game_over
    else
      self.bank = self.bank + value
    end
  end

  def game_over
    self.step = :game_over
  end

  def pass
    self.step = :pass
  end

  def get
    self.step = :get
  end

  def lookup
    self.step = :lookup
  end

  def lookup?
    self.step == :lookup ? true : false
  end

  def win
    self.status = 'YOU WIN ))'
  end

  def loss
    self.status = 'YOU LOSS (('
  end

  def fifty_fifty
      self.status = 'VA-BANK !)'
  end

  def try_on_21
    case self.sum <=> 21
    when -1
      :under21
    when 0
      :equel21
    when 1
      :over21
    end
  end

  def cards_list
    list = ''
    cards.each { |card|  list += image(card) }
    list
  end

  def image(card)
     card.open? || step == :lookup ? "|#{ card.name }| " : "| * | "
  end
end

