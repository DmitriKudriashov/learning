class MenuTrains <  BaseMenu

 def initialize(trains, routes, wagons)
    @trains = trains
    @routes = routes
    @wagons = wagons
    @wagons_used = []
    @wagons_unused = []
 end

  def train_menu
    loop do
      system("clear")
      puts "------     TRAIN MENU    -----  #{message_return}"
      puts "1 - Create Cargo Train"
      puts "2 - Create Passenger Train"
      puts "3 - List trains "
      puts "4 - Set Route to Train"
      puts "5 - Menu Trains Actions:"
      puts "      ( Moving between stations, Wagons Add / Remove )"
      puts "6 - List Wagons All"
      puts "7 - List Used/Unused Wagons"
      case gets.to_i
        when 1
          create_new_train("Cargo")
        when 2
          create_new_train("Passenger")
        when 3
          list_trains
        when 4
          set_route_to_train
        when 5
          add_remove_wagon_to_tran
        when 6
          list_all_numbers("===== List all Wagons:", @wagons)
        when 7
          all_unused_wagons
          list_all_numbers("===== List Used Wagons:", @wagons_used)
          list_all_numbers("===== List Unused Wagons:", @wagons_unused)
        else
           break
        end
    end # loop
  end

  def add_remove_wagon_to_tran
    # 1) надо выбрать из списка поездов только 1 для дальнейших действий
    # 2) надо создавать вагоны по типу
    # 3) прицеплять / отцеплять
    system("clear")
    loop do
      break unless select_train_as_current
      loop do
        system("clear")
        puts "---- Actions for Train: type - #{@train_type};  number - #{@train_number} #{message_return} "
        puts "1 - New wagon create "
        puts "2 - Add wagon to train "
        puts "3 - Remove wagon from train"
        puts "4 - List wagons of current train"
        puts "5 - Current Station "
        puts "6 - Move Train To forvard Station"
        puts "7 - Move Train To backward Station"
       item = gets.to_i
        case item
          when 1
            wagon = create_wagon(@train_type)
          when 2
            add_wagon_to_train(@train_current)
          when 3
            remove_wagon_from_train(@train_current)
          when 4
            numbers_objects_list(@train_current.wagons)
            gets # pause
          when 5
            current_station(@train_current)
          when 6
            move_forward(@train_current)
          when 7
            move_backward(@train_current)
          else
            break
        end
      end
    end
  end

  def current_station(train)
   puts "Trains current station: #{train.current_station.name}"
   gets
  end

  def move_forward(train)
    puts "Trains forward station: #{train.forward_station.name}\n go....."
    train.go_forward
    current_station(train)
  end

  def move_backward(train)
    puts "Trains backward station: #{train.backward_station.name}\n go...."
    train.go_backward
    current_station(train)
  end


  def create_wagon(type)
    count_loop = 0
    loop do
      count_loop += 1
      puts "#{count_loop}. Input Number for New #{type} Wagon : "
      number_wagon = gets.chomp.upcase
      break if number_wagon.strip.empty?
      if type == "Cargo"
        wagon = CargoWagon.new(number_wagon)
      else
        wagon = PassengerWagon.new(number_wagon)
      end
      unless make_array_numbers(@wagons).include?(wagon.number)
        @wagons << wagon
      else
        puts "This wagon: #{wagon.number} Already Exists! "
      end
    end
  end

  def select_train_as_current # выберем один из поездов для дальнейших действий
    selected_number =  selected_from_numbers("-> Your Must Select Train as current:  #{message_return}", @trains) - 1
    if -1 < selected_number && selected_number < @trains.size
      @train_current = @trains[selected_number]
      @train_number = @trains[selected_number].number
      @train_type = @trains[selected_number].type
      true   # так мне понятнее что возвращает метод
    else
      false
    end
  end

  def create_new_train(type)
    system("clear")
    count_loop = 0
    loop do
      count_loop += 1
      puts "#{count_loop}. Create New  #{type} Train #{message_return}"
      number = gets.chomp.upcase
      break if  number.strip.empty?
      if type == "Cargo"
        new_train = CargoTrain.new(number)
      else
        new_train = PassengerTrain.new(number)
      end
      if make_array_numbers(@trains).include?(new_train.number)
        puts "The Train Number: #{number} Already Exists!"
      else
        @trains << new_train
      end
    end # loop
 end

  def list_trains
    system("clear")
    puts "======> List Trains:  "
    numbers_objects_list(@trains)
    puts "Press <Enter>  key to Return"
    gets
  end

  def set_route_to_train
    system("clear")
    menu_for_select_train_and_route( " - - - - list trains for select - - - - #{message_return} ", @trains, @routes)
  end

  def all_unused_wagons
    @wagons_unused = []
    @wagons_used = []
    @trains.each { |t| @wagons_used += t.wagons }
    @wagons_unused = @wagons - @wagons_used  #unless @wagons_used.empty? || @wagons.empty?
  end

  def add_wagon_to_train(train_current)
    puts "======> Add wagon to train current No #{train_current.number}: \ + #{message_return}"
    count_loop = 0
    loop do
      count_loop += 1
      puts "#{count_loop}. ===> You must make select item from list: "
      all_unused_wagons # only not used wagons need !
      wagons_selected = @wagons_unused.select { |w| w.type == train_current.type} # wagons - only type by current train
      numbers_objects_list(wagons_selected)
      item_number = gets.to_i - 1
      break if item_number < 0 || item_number > wagons_selected.size - 1
      if !train_current.add_wagon(wagons_selected[item_number]).nil?
        puts "To the Train: #{train_current.number} added wagon #{wagons_selected[item_number].number} \n Press <Enter> ..."
        gets #  пауза для просмотра
      end
    end
  end

  def remove_wagon_from_train(train_object)
    loop do
      system("clear")
      puts "======> Remove wagon from train: #{train_object.number} =====  #{message_return}"
      numbers_objects_list(train_object.wagons)
      item_number = gets.to_i - 1
      break if item_number < 0 || item_number > train_object.wagons.size - 1
      if train_object.delete_wagon(train_object.wagons[item_number])
        puts "This Wagon: #{train_object.wagons[item_number]} Removed Successfully from Train: #{train_object.number} \n Press <Enter> ..."
        gets # pause for look
      end
    end
  end

  def selected_from_numbers(name_menu, array_objects)
    system("clear")
    puts name_menu unless name_menu.empty?
    numbers_objects_list(array_objects)
    gets.to_i
  end

end # class MenuTrains
