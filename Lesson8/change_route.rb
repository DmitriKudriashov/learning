#  For add / remove station from route
module ChangeRoute
  def add_station(stations_all, route)
    stations_left = stations_all - route.stations
    names_list!(stations_left)
    indx = gets.to_i - 1
    stations_left[indx] if indx.between?(0, stations_left.size - 1)
  end

  def remove_station(route)
    stations_route = route.stations
    names_list(stations_route)
    indx = gets.to_i - 1
    stations_route[indx] if indx.between?(0, stations_route.size - 1)
  end

  def select_station(stations, route, action)
    puts "Select station for action:  #{message_return} "
    action ? add_station(stations, route) : remove_station(route)
  end

  def change_route(name_menu, routes, stations, action)
    puts name_menu unless name_menu.empty?
    loop do
      indx = route_for(routes)
      break unless indx.between?(0, routes.size - 1)

      route = routes[indx]
      station = select_station(stations, route, action)
      break if station.nil?

      add_or_remove_station(action, indx, routes, station)
      gets
    end
  end

  def add_or_remove_station(action, indx, routes, station)
    puts "====>> Selected Station: #{station.name}"
    route_as_string = route_string(indx, routes)
    if action
      adding_station(indx, route_as_string, routes, station)
    else
      removed_station(indx, route_as_string, routes, station)
    end
  end

  def route_for(routes)
    indx = only_routes(routes) - 1
    if indx.between?(0, routes.size - 1)
      puts "====>> Selected Route: #{route_string(indx, routes)}!"
    end
    indx
  end

  def route_string(indx, routes)
    route = routes[indx]
    route_to_string(route)
  end

  def adding_station(indx, route_as_string, routes, station)
    route = routes[indx]
    if route.add_station(station).nil?
      puts " The station: #{station.name} NOT Added
            to the Route: #{route_as_string}!"
      false
    else
      puts "To the Route: #{route_as_string} added  station:
            #{station.name} --> Successfully !"
      puts "New Route: #{route_string(indx, routes)}"
      true
    end
  end

  def removed_station(indx, route_as_string, routes, station)
    route = routes[indx]
    if route.delete_station(station).nil?
      puts "The station: #{station.name}
      NOT removed from Route: #{route_as_string}"
    else
      puts "The station: #{station.name}
      Successfully removed from Route: #{route_as_string}"
      puts "New Route: #{route_to_string(routes[indx])}"
    end
  end
end
