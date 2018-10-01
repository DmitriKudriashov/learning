# Menu Train
class MenuTrains
  include BaseMenu
  include ApendixMenuTrains
  include GlobalValues

  attr_reader :trains, :routes, :wagons, :wagons_used, :wagons_unused

  def initialize(trains, routes, wagons)
    @trains = trains
    @routes = routes
    @wagons = wagons
    @wagons_used = []
    @wagons_unused = []
  end

  def train_menu
    loop do
      system('clear')
      puts "------     TRAIN MENU    -----  #{message_return}"
      puts '1 - Create Cargo Train'
      puts '2 - Create Passenger Train'
      puts '3 - List trains '
      puts '4 - Set Route to Train'
      puts '5 - Menu Trains Actions:'
      puts '      ( Moving between stations, Wagons Add / Remove )'
      puts '6 - List Wagons All'
      puts '7 - List Used/Unused Wagons'
      case gets.to_i
      when 1
        create_new_train(CARGO)
      when 2
        create_new_train(PASSENGER)
      when 3
        list_trains
      when 4
        name_menu = " - - - list trains for select - - - #{message_return} "
        train_and_route(name_menu, @trains, @routes)
      when 5
        add_remove_wagon_to_tran
      when 6
        list_all_numbers('===== List all Wagons:', @wagons)
      when 7
        all_unused_wagons
        list_all_numbers('===== List Used Wagons:', @wagons_used)
        list_all_numbers('===== List Unused Wagons:', @wagons_unused)
      else
        break
      end
    end
  end

  def add_remove_wagon_to_tran
    system('clear')
    loop do
      break unless select_train_as_current
      break if train_current_actions(@train_current)
    end
  end

  def train_actions
    ['New wagon create ',
     'Add wagon to train ',
     'Remove wagon from train',
     'List wagons of current train',
     'Current Station ',
     'Move Train To forvard Station',
     'Move Train To backward Station']
  end

  def train_current_actions(train)
    return_value = false
    loop do
      system('clear')
      msg = "#{train.number} type: #{train.type}#{message_return}"
      puts "-> Actions for Train: #{msg} "
      listing_block(train_actions) { |indx, txt| puts "#{indx} - #{txt}" }
      case gets.to_i
      when 1
        create_wagon(train.type)
      when 2
        name_menu = "==> Add wagon to train No #{train.number}:#{message_return}"
        add_wagon_to_train(name_menu, train)
      when 3
        name_menu = "==> Remove wagon from train: #{train.number}#{message_return}"
        remove_wagon_from_train(name_menu, train)
      when 4
        listing_block(train.wagons) { |indx, w| puts "#{indx}. #{w.number}  #{w.type}" }
        gets
      when 5
        current_station(train)
      when 6
        move_forward(train)
      when 7
        move_backward(train)
      else
        return_value = true
        break
      end
    end
    return_value
  end

  def current_station(train)
    puts "Train current station: #{train.current_station.name}"
    gets
  end

  def move_forward(train)
    from_station = train.current_station.name
    to_station = train.forward_station.name
    puts "Train go forward from #{from_station} to the station: #{to_station}"
    puts 'go....'
    train.go_forward
    current_station(train)
  end

  def move_backward(train)
    from_station = train.current_station.name
    to_station = train.backward_station.name
    path = "#{from_station} to the station: #{to_station}"
    puts "Train backward from #{path}\n go...."
    train.go_backward
    current_station(train)
  end

  def create_new_train(type)
    system('clear')
    count_loop = 0
    loop do
      count_loop += 1
      new_train = train(count_loop, type)
      break if new_train.nil?

      puts "new_train.number = #{new_train.number}"
      if make_array_numbers(@trains).include?(new_train.number)
        puts "The Train Number: #{new_train.number} Already Exists!"
      else
        @trains << new_train
      end
    end
  end

  def train(count_loop, type)
    puts "#{count_loop}. Create New #{type} Train"
    puts "Input Number for train #{press_enter}"
    number = gets.chomp.upcase.strip
    return if number.empty?

    train_new(type, number)
  rescue StandardError => e
    puts "Error: #{e.message}\n Enter other number please...!) "
    retry
  end

  def train_new(type, number)
    type.eql?(CARGO) ? CargoTrain.new(number) : PassengerTrain.new(number)
  end

  def list_trains
    system('clear')
    puts '======> List Trains:  '
    @trains.sort_by!(&:number)
    listing_block(@trains) { |indx, train| puts to_text(indx, train) }
    puts 'Press <Enter>  key to Return'
    gets
  end

  def to_text(indx, train)
    "#{indx}. #{train.number}, type: #{train.type}, wagons: #{train.wagons.size}"
  end

  def all_unused_wagons
    @wagons_unused = []
    @wagons_used = []
    @trains.each { |t| @wagons_used += t.wagons }
    @wagons_unused = @wagons - @wagons_used
  end

  def select_train_as_current
    system('clear')
    name_menu = "-> Your Must Select Train as current:#{message_return}"
    @trains.sort_by!(&:number)
    selected_number = selected_from_numbers(name_menu, @trains) - 1
    if selected_number.between?(0, @trains.size - 1)
      @train_current = @trains[selected_number]
      @train_number = @train_current.number
      @train_type = @train_current.type
      true
    else
      false
    end
  end
end
