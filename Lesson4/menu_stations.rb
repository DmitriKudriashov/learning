class MenuStations < BaseMenuClass
  attr_reader :stations

  def initialize(stations)
     @stations = stations
     menu_stations
  end

  def menu_stations
    loop do
      system('clear')
      puts "-------    STATION MENU    ------\n" + message_return
      puts "1 - Create New Station"       #- Создавать станции
      puts "2 - List Stations "  #- Просматривать список станций
      puts "3 - List Trains on Selected Station" #- список поездов на станции
      case gets.to_i
        when 1
          create_new_station
        when 2
          list_all_stations
        when 3
          look_trains_by_stations(" - - - - list stations for select - - - -\n" + message_return, @stations)
        else
          break
      end
    end # loop
  end

  def create_new_station
    system('clear')
    puts "- - -     Create New Station    - - - \n" + message_return
    count_loop = 0
    loop do
      count_loop += 1
      puts "#{count_loop}. Name New Station: "
      name_station  = gets.chomp.capitalize
      if name_station.empty?
        break
      else
        new_station = Station.new(name_station)
        if @stations.include?(new_station)
          puts "The Station: #{new_station} Already Exists !"
        else
          @stations << new_station
        end
      end
    end #loop do
    sort_array_objects_by_name(@stations)
  end

  def list_all_stations
    system("clear")
    puts "- - - -  list all stations - - - - "
    names_list(@stations)
    puts "Press <Enter> key..."
    gets #  использую для остановки процесса, может есть другой способ?  надо потом поискать!
  end

  def list_trains_of_station(station) # this is station - it's object
    system("clear")
    puts "......  List Trains on station #{station.name}.......\n" + message_return
    station.trains.each { |t| puts t.number }
    gets
  end

  def look_trains_by_stations(name_menu, array_items_menu)
    loop do
      selected_number = select_from_names(name_menu, array_items_menu) - 1
      break if selected_number < 0 || selected_number > array_items_menu.size - 1
      list_trains_of_station(array_items_menu[selected_number]) # показать список поездов на станции
    end #loop do
  end
end
