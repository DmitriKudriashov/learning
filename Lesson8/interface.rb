class Interface
  include BaseMenu
  include Primary
  include ChangeRoute

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def start
    primary
    @station_actions = MenuStations.new(@stations)
    @trains_actions = MenuTrains.new(@trains, @routes, @wagons)
    run
  end

  def run
    loop do
      system('clear')
      puts '======= MAIN MENU ========= '
      puts '1 - Stations'
      puts '2 - Trains'
      puts '3 - Routes'
      puts '(Input Number for action or <Enter> key - EXIT ! ) '
      case gets.to_i
      when 1
        @station_actions.station_menu
      when 2
        @trains_actions.train_menu
        gets
      when 3
        menu_routes
      else
        break
      end
    end
    system('clear')
  end

  protected

  def menu_routes
    loop do
      system('clear')
      puts "---     ROUTES MENU    --- #{message_return}"
      puts '1 - Create New Route'
      puts '2 - List Routes '
      puts '3 - Add Station'
      puts '4 - Remove Station'
      case gets.to_i
      when 1
        create_route
      when 2
        only_routes(@routes)
      when 3
        name_menu = '======> Add Station to Route =========== '
        change_route(name_menu, @routes, @stations, true)
      when 4
        name_menu = '======> Remove Station from Route ====== '
        change_route(name_menu, @routes, @stations, false)
      else
        break
      end
    end
  end

  def create_route
    loop do
      system('clear')
      puts '- - - Create New Route - - - '
      stations = {}
      stations = first_and_last(stations)
      break if stations['first'].to_s.empty? || stations['last'].to_s.empty?

      new_route = new_route_creating(stations['first'], stations['last'])
      route_check_and_add(new_route) unless new_route.nil?
      gets
    end
  end

  def first_and_last(stations)
    %w[first last].each do |indx|
      message = "Select number item from list for #{indx} station of route:"
      stations[indx] = select_station_new_route(message)
      break if stations[indx].to_s.empty?

      puts "=>>  #{indx.capitalize} station of route: #{stations[indx].name}"
    end
    stations
  end

  def new_route_creating(first_station, last_station)
    Route.new(first_station, last_station)
  rescue StandardError => e
    puts "Route can't be created! Error : #{e.message}!!!"
  end

  def route_check_and_add(new_route)
    first = new_route.first_station.name
    last = new_route.last_station.name
    new_route_string = "Route: #{first} -> #{last}"
    if routes_to_strings(@routes).include?(route_to_string(new_route))
      puts "This Route: #{new_route_string} Already Exist!"
    else
      @routes << new_route
      puts "This Route: #{new_route_string} Successfully Added to the Routs List!"
    end
  end

  def select_station_new_route(message)
    names_list!(@stations)
    puts message
    indx = gets.to_i - 1
    @stations[indx] if indx.between?(0, @stations.size - 1)
  end
end
