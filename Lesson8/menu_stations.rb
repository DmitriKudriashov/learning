#  Stations
class MenuStations
  include BaseMenu
  include ApendixMenuStations
  include GlobalValues

  attr_reader :stations

  def initialize(stations)
    @stations = stations
  end

  def station_menu
    loop do
      system('clear')
      puts "-------    STATION MENU    ------ #{message_return} "
      puts '1 - Create New Station'
      puts '2 - List Stations'
      puts '3 - List Trains on Selected Station'
      puts '4 - List All Stations with trains'
      case gets.to_i
      when 1
        create_new_station
      when 2
        list_all_stations
      when 3
        name_menu = " - - list stations for select - - #{message_return}"
        look_trains_by_stations(name_menu, @stations)
      when 4
        name_menu = " - - All Stations with Trains - - #{message_return}"
        list_all_stations_with_trains(name_menu, @stations)
      else
        break
      end
    end
  end

  protected

  def list_all_stations_with_trains(name_menu, stations)
    system('clear')
    puts name_menu
    listing_block(stations) { |indx, station| string_train(indx, station) }
    gets
  end

  def string_train(indx, station)
    puts mssg(indx, station)
    trains_wagons(station)
  end

  def mssg(indx, station)
    quantity = "quantity trains: #{station.trains.size.to_i}"
    "#{indx}.  #{station.name}, #{quantity}: "
  end

  def trains_wagons(station)
    station.train_into_block station.trains, train_block
  end

  def train_block
    ->(train) { puts_train_wagons(train, wagon_block) }
  end

  def puts_train_wagons(train, wagon_block)
    puts mssg_train(train)
    train.wagon_into_block train.wagons, wagon_block
  end

  def mssg_train(train)
    size = "total wagons: #{train.wagons.size}"
    " Train No: #{train.number}, type: #{train.type}, #{size}"
  end

  def wagon_block
    ->(w) { puts "    wagon: #{w.number}, type: #{w.type}, #{mssg_wagon(w)}" }
  end

  def mssg_wagon(wagon)
    " #{volume_name(wagon.type)} used: #{wagon.busy}, free: #{wagon.unbusy}"
  end

  def list_all_stations
    puts '- - -  list all stations  - - - '
    names_list(@stations)
    puts 'Press <Enter> key...'
    gets
  end

  def list_trains_of_station(station)
    puts "...  List Trains on station #{station.name} ... "
    puts '     (Press <EnterKey> to Return )'
    listing_block(station.trains) { |indx, t| puts mssg_trains(indx, t) }
  end

  def mssg_trains(indx, train)
    "#{indx}. Train No: #{train.number}, type: #{train.type}"
  end

  def look_trains_by_stations(name_menu, stations)
    loop do
      system('clear')
      puts name_menu
      item = select_from_names(stations) - 1
      break unless item.between?(0, stations.size - 1)

      station = stations[item]
      list_trains_of_station(station)
      gets
    end
  end
end
