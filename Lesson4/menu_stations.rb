class MenuStations < BaseMenu
  attr_reader :stations

  def initialize(stations)
    @stations = stations
  end

  def station_menu
    loop do
      system('clear')
      puts "-------    STATION MENU    ------ #{message_return} "
      puts "1 - Create New Station"       #- Создавать станции
      puts "2 - List Stations"            #- Просматривать список станций
      puts "3 - List Trains on Selected Station" #- список поездов на выбранной станции
      case gets.to_i
      when 1
        create_new_station
      when 2
        list_all_stations
      when 3
        look_trains_by_stations(" - - - - list stations for select - - - - #{message_return} ", @stations)
      else
        break
      end
    end # loop
  end

  protected

  def create_new_station
    system('clear')
    puts "- - -     Create New Station    - - -  #{message_return}"
    count_loop = 0
    loop do
      count_loop += 1
      puts "#{count_loop}. Name New Station: "
      name_station  = gets.chomp.upcase.strip
      break if name_station.empty?
      new_station = Station.new(name_station)
      if (make_array_names(@stations) * ";").upcase.include?(name_station) # создать из массива имен строку, для перевода ее в верхний регистр.
        puts "The Station: #{name_station} Already Exists !"
      else
        @stations << new_station
        sort_array_objects_by_name(@stations)
      end
    end #loop do
  end

  def list_all_stations # список станций с поездами
=begin # закоментил пока.. много вложений, пред. вариант проще, хотя этот наглядно показывает какик поезда на каждой станции..Но может и не нужно это...
    system("clear")
    puts "- - - -  list all stations and trains - - - - "
    indx_s = 0
    @stations.each do |s|
      indx_s += 1
      puts "#{indx_s}. #{s.name},  quantty trains: #{s.trains.size.to_i}"
      if s.trains.size.to_i > 0
        puts   "---- trains:"
        indx_t = 0
        s.trains.each do |t|
          indx_t += 1
          puts "       #{indx_t}. #{t.number}  #{t.type}"
        end
      end
    end
    gets
=end
    # предыдущий вариант.  простой список станций без поездов
    puts "- - - -  list all stations  - - - - "
    names_list!(@stations)
    puts "Press <Enter> key..."
    gets #  использую для остановки процесса, может есть другой способ?  надо потом поискать!
  end

  def list_trains_of_station(station) # this is station - it's object
    puts "......  List Trains on station #{station.name}....... \n(.....  Press <EnterKey> to Return ..... )"
    station.trains.each { |t| puts "Train No: #{t.number}, type: #{t.type} " }
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
