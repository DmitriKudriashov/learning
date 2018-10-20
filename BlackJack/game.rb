# game.rb
require 'io/console'
class Game
  include Accessors
  include GlobalValues
  include CommonMethods

  attr_accessor_with_history :game_bank
  attr_reader :name, :user, :dealer, :box

  def initialize(user, dealer)
    @user = user
    @dealer = dealer
    @name = user.name
    @box = CardsBox.new
    2.times { give_cards }
  end

  def bets
   self.game_bank = user.bet + dealer.bet
  end

  def give_cards
    user_get_card
    dealer_get_card
  end

  def user_get_card
    new_card = box.give_out
    new_card.open!
    user.get_card new_card
  end

  def dealer_get_card
    dealer.get_card box.give_out
  end

  def view_sum_dealer
    dealer.lookup? ? dealer.sum.to_s : "***"
  end

  def menu_first
    [ 'Get card',
      'Pass',
      'Open cards']
  end

  def menu_second
    [ menu_first.first, menu_first.last]
  end

  def menu
    if user.try_on_21 == :equel21
      dealer_next_step
      open_cards
    else
      user.step == :pass ? menu_second : menu_first
    end
  end

  def select_from_menu_first(item)
    case item
    when 1
      next_card
      open_cards
    when 2
      user_pass
      open_cards
    when 3
      open_cards
    end
  end

  # don't executed in current version ... may be future?
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

  def information
    system('clear')
    puts '============================================'
    puts "GAME No: #{user.game_number}  BANK: #{self.game_bank} "
    puts '============================================'
    puts "  USER: #{user.name} step: #{user.step} \n cards: #{user.cards_list} sum: #{user.sum},  balance: #{user.bank} "
    puts '--------------------------------------------'
    puts "DIALER: #{@dealer.name} step: #{dealer.step}  \n cards: #{dealer.cards_list} sum: #{view_sum_dealer}, balance: #{dealer.bank}"
    puts " ( control sum: #{self.game_bank + user.bank + dealer.bank } )" # for code debug only !
  end

  def menu_view
    puts '--------------------------------------------'
    puts "       Select Action  #{msg_return}"
    puts '--------------------------------------------'
    listing_block(menu) { |item, text| puts "#{item}. #{text}" }
    STDIN.getch
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
                       # half = bankself.game_bank/2
    user.bet_return    # change_bank(half)
    dealer.bet_return  # change_bank(half)
    self.game_bank = 0
  end

  def run
    if user.try_on_21 == :equel21
       dealer_next_step
       open_cards
    else
      action_from_menu
    end
  end

  def action_from_menu
    loop do
      information
      item = menu_view
      break if item.ord == 27 || item.empty?
      break if case_menu(item.to_i)
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
    information
    puts "\n -------------------- \n #{user.status} \n --------------------"
    true
  end

  def user_pass
    user.pass
    dealer_next_step
    false
  end

  def next_card
    user_get_card
    dealer_next_step
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
    user_loss if user.try_on_21 == :over21
    compare_sums if user.try_on_21 == :under21 && dealer.try_on_21 == :under21
    user_fifty_fifty if user.try_on_21 == :equel21 && dealer.try_on_21 == :equel21
    user_win if user.try_on_21 != :over21 && dealer.try_on_21 == :over21
    user_win if user.try_on_21 == :equel21 && dealer.try_on_21 != :equel21
  end

  def new_or_close
    puts "User bank history: #{user.bank_history}"
    puts "User card sum history: #{user.sum_history}"
    puts "Dealer bank history: #{dealer.bank_history}"
    puts "Dealer card sum history: #{dealer.sum_history}"
    loop do
      puts "===============================
        Start new game?
     (Y)es  /  (ESC) for Exit "
      char = STDIN.getch
      return true if char.ord == 27
      if char.chomp.upcase == "Y"
        user.new_game_init
        dealer.new_game_init
        return false
      end
    end
  end
end
