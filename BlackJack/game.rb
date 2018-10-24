# game.rb
require 'io/console'
class Game
  include Accessors

  attr_reader_private_writer :game_bank
  attr_reader :user, :dealer, :deck, :number

  def initialize(user, dealer, number)
    @user = user
    @dealer = dealer
    @number =  number
    @deck = Deck.new
  end

  def bets
   self.game_bank = user.bet + dealer.bet
  end

  def give_cards
    2.times { user_get_card }
    2.times { dealer_get_card }
  end

  def user_get_card
    new_card = deck.give_out
    new_card.open!
    user.get_card new_card
  end

  def dealer_get_card
    dealer.get_card deck.give_out
  end


  def select_from_menu_first(item)
    case item
    when 1
      next_card
      open_cards
    when 2
      user_pass
    when 3
      open_cards
    end
  end

  def select_from_menu_second(item)
    case item
    when 1
      next_card
      open_cards
    when 2
      open_cards
    end
  end

  def case_menu(item)
    user.step == :pass ? select_from_menu_second(item) : select_from_menu_first(item)
  end

  def user_loss
    user.loss
    dealer.win
    dealer.change_bank(self.game_bank)
    self.game_bank = 0
  end

  def user_win
    user.win
    user.change_bank(self.game_bank)
    dealer.loss
    self.game_bank = 0
  end

  def user_fifty_fifty
    user.fifty_fifty
    dealer.fifty_fifty
    user.bet_return
    dealer.bet_return
    self.game_bank = 0
  end

  def run
    user.new_game_init
    dealer.new_game_init
    bets
    give_cards
    if user.try_on_21 == :equel21
       dealer_next_step
       open_cards
    end
  end


  def lookup
   user.lookup
   dealer.lookup
   true
  end

  def open_cards
    lookup
    check_sums
    true
  end

  def user_pass
    user.pass
    dealer_next_step
    false
  end

  def next_card
    user_get_card
    dealer_next_step if dealer.cards.size < 3
    false
  end

  def dealer_next_step
    dealer.sum >= 17 ? dealer.pass : dealer.get
    dealer_get_card if dealer.step == :get
  end

  def compare_sums
    case user.sum <=> dealer.sum
    when -1
      user_loss
    when 0
      user_fifty_fifty
    when 1
      user_win
    end
  end

  def check_sums
    user_level = user.try_on_21
    dealer_level = dealer.try_on_21
    user_loss if user_level == :over21
    user_loss if user_level == :under21 && dealer_level == :equel21
    compare_sums if user_level == :under21 && dealer_level == :under21
    user_fifty_fifty if user_level == :equel21 && dealer_level == :equel21
    user_win if user_level != :over21 && dealer_level == :over21
    user_win if user_level == :equel21 && dealer_level != :equel21
  end

end
