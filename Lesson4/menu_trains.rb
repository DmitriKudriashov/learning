class MenuTrains <  BaseMenuClass

  def initialize (trains, routes, wagons)
    @trains = trains
    @routes = routes
    @wagons = wagons
    primary
    menu_trains

  end

  def primary
    super
   # ---------------- здесь  p - Passenger, c - Cargo, t - Train
    pt1 = PassengerTrain.new("P100")
    pt2 = PassengerTrain.new("P200")
    pt3 = PassengerTrain.new("P300")
    pt4 = PassengerTrain.new("P400")
    pt5 = PassengerTrain.new("P500")

    ct1 = CargoTrain.new("C100")
    ct2 = CargoTrain.new("C200")
    ct3 = CargoTrain.new("C300")
    ct4 = CargoTrain.new("C400")
    ct5 = CargoTrain.new("C500")

    pt1.set_route(@routes[1]) #(r1)
    pt2.set_route(@routes[4]) #(r4)
    pt3.set_route(@routes[2]) #(r2)
    pt4.set_route(@routes[3]) #(r3)

    ct1.set_route(@routes[2]) #(r2)
    ct2.set_route(@routes[3]) #(r3)
    ct3.set_route(@routes[4]) #(r4)
    ct4.set_route(@routes[1]) #(r1)
    ct5.set_route(@routes[3]) #(r3)
   #=======================

    cw1 = CargoWagon.new("CW0001")
   # puts "-----  cw1 --> type: #{cw1.type} ; No: #{cw1.number}"  # for debug only
    cw2 = CargoWagon.new("CW0002")
    cw3 = CargoWagon.new("CW0003")
    cw4 = CargoWagon.new("CW0004")
    cw5 = CargoWagon.new("CW0005")
    cw6 = CargoWagon.new("CW0006")
    cw7 = CargoWagon.new("CW0007")
    cw8 = CargoWagon.new("CW0008")
    cw9 = CargoWagon.new("CW0009")
    cw10 = CargoWagon.new("CW0010")
    cw11 = CargoWagon.new("CW0011")
    cw12 = CargoWagon.new("CW0012")
    cw13 = CargoWagon.new("CW0013")
    cw14 = CargoWagon.new("CW0014")
    cw15 = CargoWagon.new("CW0015")
    cw16 = CargoWagon.new("CW0016")
    cw17 = CargoWagon.new("CW0017")
    cw18 = CargoWagon.new("CW0018")
    cw19 = CargoWagon.new("CW0019")
    cw20 = CargoWagon.new("CW0020")



    pw1 = PassengerWagon.new("PW0001")
    pw2 = PassengerWagon.new("PW0002")
    pw3 = PassengerWagon.new("PW0003")
    pw4 = PassengerWagon.new("PW0004")
    pw5 = PassengerWagon.new("PW0005")
    pw6 = PassengerWagon.new("PW0006")
    pw7 = PassengerWagon.new("PW0007")
    pw8 = PassengerWagon.new("PW0008")
    pw9 = PassengerWagon.new("PW0009")
    pw10 = PassengerWagon.new("PW0010")
    pw11 = PassengerWagon.new("PW0011")
    pw12 = PassengerWagon.new("PW0012")
    pw13 = PassengerWagon.new("PW0013")
    pw14 = PassengerWagon.new("PW0014")
    pw15 = PassengerWagon.new("PW0015")
    pw16 = PassengerWagon.new("PW0016")
    pw17 = PassengerWagon.new("PW0017")

    @wagons = [cw1, cw2, cw3,  cw4, cw5, cw6, cw7, cw8, cw9, cw10, cw10, cw11, cw12, cw13, cw14, cw15, cw16, cw17, cw18, cw19, cw20, pw1, pw2, pw3, pw4, pw5, pw6, pw7, pw8, pw9, pw10, pw11, pw12, pw13, pw14, pw15, pw16, pw17]

    ct1.add_wagon(cw1)
    ct1.add_wagon(cw3)
    ct1.add_wagon(cw5)
    ct1.add_wagon(cw7)
    ct1.add_wagon(cw9)
#    puts "----ct1-----"                               # for debug only
#    ct1.wagons.each { |w| puts "No: #{w.number}"}     # for debug only
#    puts "----------"                                 # for debug only
#    gets                                              # for debug only
    ct2.add_wagon(cw2)
    ct2.add_wagon(cw4)
    ct3.add_wagon(cw6)
    ct4.add_wagon(cw8)
    ct5.add_wagon(cw10)

    pt1.add_wagon(pw1)
    pt1.add_wagon(pw3)
    pt1.add_wagon(pw5)
    pt1.add_wagon(pw7)
    pt1.add_wagon(pw9)

    pt2.add_wagon(pw2)
    pt2.add_wagon(pw4)
    pt2.add_wagon(pw6)
    pt2.add_wagon(pw8)
    pt2.add_wagon(pw10)

    @trains = [ct1, ct2, ct3, ct4, ct5, pt1, pt2, pt3, pt4, pt5]
  end

  def menu_trains
    loop do
      system("clear")
      puts "------     TRAIN MENU    -----\n" + message_return
      puts "1 - Create Cargo Train"
      puts "2 - Create Passenger Train"
      puts "3 - List trains "
      puts "4 - Set Route to Train"
      puts "5 - Add / Remove wagon to current Train"
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
        puts "----- Actions Wagons for Train: type - #{@train_type};  number - #{@train_number} \n" + message_return
        puts "1 - New wagon create "
        puts "2 - Add wagon to train "
        puts "3 - Remove wagon from train"
        puts "4 - List wagons of current train"
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
          else
            break
        end
      end
    end
  end

  def create_wagon(type)
    count_loop = 0
    loop do
      count_loop += 1
      puts "#{count_loop}. Input Number for New #{type} Wagon : "
      number_wagon = gets.chomp.upcase
      break if number_wagon.strip.empty?
      if type == "Cargo"
        wagon = CargoTrain.new(number_wagon)
      else
        wagon = PassengerTrain.new(number_wagon)
      end
      unless @wagons.include?(wagon)
        @wagons << wagon
       # list_all_numbers("=====> List All Wagons: ", @wagons) # for debug only
      else
        puts "This wagon: #{wagon} Already Exists! "
      end
    end
  end

  def select_train_as_current # выберем один из поездов для дальнейших действий
      selected_number =  selected_from_numbers("-> Your Must make Select Train as current: \n" + message_return, @trains) - 1
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
      puts "#{count_loop}. Create New  #{type} Train \n" + message_return
      number = gets.chomp.upcase
      break if  number.strip.empty?
      if type == "Cargo"
        new_train = CargoTrain.new(number)
      else
        new_train = PassengerTrain.new(number)
      end
      if @trains.include?(new_train)
        puts "The Train Number: #{number} Already Exists!"
      else
        @trains << new_train
      end
    end # loop
    sort_array_objects_by_number(@trains)
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
    menu_for_select_train_and_route( " - - - - list trains for select - - - -\n" + message_return, @trains)  # список поездов
  end

  def all_unused_wagons
    @wagons_unused = []
    @wagons_used = []
    @trains.each { |t| @wagons_used = @wagons_used + t.wagons}
    @wagons_unused = @wagons - @wagons_used
   # puts "--------- >>>>>>>> all used wagons"               # for debug only
   # @wagons_used.each { |w| puts "W.No : #{w.number}"}      # for debug only
   # puts "--------- >>>>>>>> all Unused wagons"             # for debug only
   # @wagons_unused.each { |w| puts "W.No : #{w.number}"}    # for debug only
   # gets                                                    # for debug only
  end

  def add_wagon_to_train(train_current)
    puts "======> Add wagon to train current No #{train_current.number}: \n" + message_return
    count_loop = 0
    loop do
      count_loop += 1
      puts "#{count_loop}. ===> You must make select item from list: "
      all_unused_wagons # only not used wagons need !
      wagons_selected = @wagons_unused.select { |w| w.type == train_current.type} # wagons - only type by current train
      sort_array_objects_by_number(wagons_selected)
      numbers_objects_list(wagons_selected)
      item_number = gets.to_i - 1
      break if item_number < 0 || item_number > wagons_selected.size - 1
      if train_current.add_wagon(wagons_selected[item_number])
        puts "To the Train: #{train_current.number} added wagon #{wagons_selected[item_number].number} \n Press <Enter> ..."
        gets #  пауза для просмотра
      end
    end
  end

  def remove_wagon_from_train(train_object)
    loop do
      system("clear")
      puts "======> Remove wagon from train: #{train_object.number} =====  \n" + message_return
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
    selected_number = gets.to_i
  end

  def menu_for_select_train_and_route(name_menu, array_objects)
   loop do
      selected_number =  selected_from_numbers(name_menu, array_objects) - 1
      break if selected_number < 0 || selected_number > array_objects.size - 1
      index_route = list_routes - 1
      break if index_route < 0 || index_route > @routes.size - 1
      @trains[selected_number].set_route(@routes[index_route]) # назначение маршрута поезду
      puts "To Train: #{@trains[selected_number].number} set route: #{@route_stations[index_route]}"
      gets
    end #loop do
  end

end # class MenuTrains
