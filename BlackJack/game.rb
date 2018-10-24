# game.rb
require 'io/console'
class Game
  include Logistics
  include Accessors

  attr_reader_private_writer :game_bank
  attr_reader :user, :dealer, :deck, :number, :interface

  def initialize(user, dealer, number, interface)
    @user = user
    @dealer = dealer
    @number =  number
    @deck = Deck.new
    @interface = interface
  end

  def accepted
    open_menu if interface.start_accepted?
  end

  def open_menu
    run
    if user.status == :win
      lookup
    else
      action_from_menu
    end
    information
    interface.user_view_result user.status_text
    true
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

  def information
    info_user = {gamer: 'USER', name: user.name, step: user.step, cards: user.cards_list, sum:  user.sum, balance: user.balance}
    info_dealer = {gamer: 'DEALER', name: dealer.name, step: dealer.step, cards: dealer.cards_list, sum:  view_sum_dealer, balance: dealer.balance}
    interface.game_number(number, game_bank)
    interface.gamer_info(info_user)
    interface.devider_double
    interface.gamer_info(info_dealer)
    interface.devider_simple
    interface.control_sum( game_bank + user.balance + dealer.balance )
  end

  def menu_view
    interface.menu_view_head
    interface.select_from menu
    STDIN.getch
  end

  def action_from_menu
    loop do
      information
      item = menu_view
      break if item.ord == 27 || item.empty?
      break if case_menu(item.to_i)
    end
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
    user.step == :pass ? menu_second : menu_first
  end

  def view_sum_dealer
    dealer.lookup? ? dealer.sum.to_s : "***"
  end

  def bets
   self.game_bank = user.bet + dealer.bet
  end

  def give_cards
    2.times { user_get_card }
    2.times { dealer_get_card }
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
end
