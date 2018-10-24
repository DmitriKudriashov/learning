# gamer.rb
class Gamer
  include Accessors
  include Validation

  validate :name, :presence
  validate :name, :format, /^[A-Z]{3,}$/i
  validate :balance, :negative

  attr_reader_private_writer :sum, :step, :status, :status_text, :balance
  attr_reader :name, :cards, :bank

  BET = 10
  BANK = 100

  def initialize(name)
    @name = name
    @bank =  Bank.new(BANK)
    @balance = @bank.balance
    validate!
  end

  def new_game_init
    @cards = []
    self.step = :hide
    self.status = :none
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
    # cards.map(&:cost).count(1)
    cards.map(&:nominal).count('A')
  end

  def get_card(card)
    get
    @cards << card
    calc_sum
  end

  def bet
    self.step = :bet
    self.balance = bank.pay(BET) if valid?
    BET
  end

  def bet_return
    self.balance = bank.get(BET)
  end

  def change_bank(value)
    self.balance = bank.get(value) if valid?
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
    self.status = :win
    self.status_text = 'YOU WIN ))'
  end

  def loss
    self.status = :loss
    self.status_text = 'YOU LOSS (('
  end

  def fifty_fifty
    self.status = :fifty_fifty
    self.status_text = 'VA-BANK !)'
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

