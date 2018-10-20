# balack_jack.rb
class BlackJack
  include CommonMethods

  def start
    system('clear')
    puts 'INPUT YOU NAME:'
    name_user = gets_whith_esc #
    name_user = name_user.chomp.strip.capitalize
    exit if name_user.strip.empty?

    @user = User.new(name: name_user)
    @dealer = Dealer.new(name: 'Computer')

    loop do
      game = Game.new(@user, @dealer)
      begin
        raise "GAME OVER !" if game.bets < 20
      rescue StandardError => err
        puts "\nFor #{balance_gamer} \n #{err.message}"
        exit
      end
      game.run
      break if game.new_or_close
    end
  end

  def balance_gamer
    @user.bank < 10 ? "#{@user.name} Bank sum: #{@user.bank}" :  "#{@dealer.name} Bank sum: #{@dealer.bank}"
  end
end
