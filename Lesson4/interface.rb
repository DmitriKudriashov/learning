require_relative './base_menu_class'

class Interface < BaseMenuClass

  def initialize
    super
    run
  end

  def run
    loop do
      system('clear')
      puts "======= MAIN MENU ========="
      puts "1 - Stations"       #- Создавать станции
      puts "2 - Trains"         #- Создавать поезда
      puts "3 - Routes" #- Создавать маршруты и управлять станциями в нем (добавлять, удалять)
      puts "(Input Number for action or <Enter> key - EXIT ! ) "
      case gets.to_i
      when 1
        MenuStations.new(@stations)
      when 2
        MenuTrains.new(@trains, @routes, @wagons) # menu_trains
      when 3
        menu_routes
      else
        break
      end
    end #loop do
    system('clear')
  end

  def make_array_names(array_objects) # создать массив названий из объектов, имеющих свойство name
    names = []
    array_objects.each { |s| names << s.name}
    names
  end

  def menu_routes
    loop do
      system("clear")
      puts "--     ROUTES MENU    --"
      puts "1 - Create New Route"       #- Создавать маршрут
      puts "2 - List Routes "  #- Просматривать список маршрутов
      puts "3 - Add Station" #- добавить станцию
      puts "4 - Remove Station" #- удалить станцию
      #puts "(press Number for action, any other key - RETURN to MAIN MENU !  "
      case gets.to_i
        when 1
          create_new_route
        when 2
          list_routes
        when 3
          route_add_station
        when 4
          route_remove_station
        else
          break if condition_for_return_previous_menu
      end
    end #loop
  end

  def create_new_route
    loop do
      system("clear")
      puts "- - - Create New Route - - - "
      names_list(@stations) # array_items_menu - тут используется массив объектов станций
      puts "1) Select number item from list for First station of Route: "
      selected_number_first = gets.to_i - 1
      break if (selected_number_first < 0 || selected_number_first > @stations.size - 1 )
      first_station = @stations[selected_number_first]
      puts "====>> Fist station of route: #{first_station.name}"
      names_list(@stations) # array_items_menu - тут используется массив объектов станций
      puts "2) Select number item from list for Last station of Route: "
      selected_number_last = gets.to_i - 1
      break if (selected_number_last < 0 || selected_number_last > @stations.size - 1)
      last_station = @stations[selected_number_last]
      puts "====>> Last station of route: #{last_station.name}"
      new_route = Route.new(first_station, last_station)
      @routes << new_route unless @routes.include?(new_route)
    end # loop
  end



  def route_add_station
    system("clear")
    puts "========> Add Station to Route:"
    puts " !!!!!!!!!!!!! ON REPAIR !!!!!!!!!!!!!!!!!! "
    gets
  end

  def route_remove_station
    system("clear")
    puts "========> Remove Station from set_route:"
    puts " !!!!!!!!!!!!! ON REPAIR !!!!!!!!!!!!!!!!!! "
    gets
  end

  protected

  def condition_for_return_previous_menu
    puts "Return to the previous menu? (Y or N): "
    gets.chomp.upcase.include?("Y")
  end
end # class Interface

=begin


      puts "1 - Creating New Station"       #- Создавать станции
      puts "2 - Creating New Train"         #- Создавать поезда
      puts "3 - Creating New Routes And Managemets Routes " #- Создавать маршруты и управлять станциями в нем (добавлять, удалять)
      puts "4 - Set Route to Train" #- Назначать маршрут поезду
      puts "5 - Added new wagons to Train" #- Добавлять вагоны к поезду
      puts "6 - Remove wagons from Train" #- Отцеплять вагоны от поезда
      puts "7 - Move Traine by Route" #- Перемещать поезд по маршруту вперед и назад
      puts "8 - List Stations and Trains " #- Просматривать список станций и список поездов на станции"

=end

