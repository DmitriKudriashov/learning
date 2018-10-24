# balack_jack.rb
class BlackJack
  attr_reader :user, :dealer, :number, :interface

  def initialize
    @dealer = Gamer.new('Computer')
  end

  def start
    @interface = Interface.new
    dealer.new_game_init
    name_new = interface.ask_user_name
    @user = Gamer.new(name_new)
    user.new_game_init
    @number = 0
    balance_gamer if game_run?
  end

  def game_run?
    loop do
      @number += 1
      game = Game.new(user, dealer, number, interface)
      return false if !game.accepted
      return true if game.game_over?
    end
    true
  end

  def balance_gamer
    user.balance < Gamer::BET ? "#{user.name} Bank sum: #{user.balance}" :  "#{dealer.name} Bank sum: #{dealer.balance}"
  end
end
