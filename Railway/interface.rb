require_relative 'base_menu'

class Interface < BaseMenu

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

  def primary # для отладки , чтобы не с нуля заполнять данные
    s11 = Station.new("NewYork")
    s12 = Station.new("Orlando")
    s13 = Station.new("Portlend")
    s14 = Station.new("Washington")
    s15 = Station.new("San Diego")
    s21 = Station.new("Chicago")
    s22 = Station.new("Detroit")
    s23 = Station.new("Pittsburg")
    s24 = Station.new("Atlanta")
    s25 = Station.new("Dallas")
    @stations = [s11,s15,s21,s25,s14,s13,s22,s24,s12,s23]
    # ------------- Routes
    r1 = Route.new(s11,s25)
    r1.add_station(s15)
    r1.add_station(s21)

    r2 = Route.new(s14,s22)
    r2.add_station(s13)
    r2.add_station(s24)

    r3 = Route.new(s23,s24)
    r3.add_station(s12)
    r3.add_station(s13)
    r3.add_station(s11)

    r4 = Route.new(s13,s24)
    r4.add_station(s22)
    r4.add_station(s23)
    r4.add_station(s25)
    r4.add_station(s14)

    @routes = [r1,r3,r2,r4]
   # ---------------- здесь  p - Passenger, c - Cargo, t - Train
    pt1 = PassengerTrain.new("P10-00")
    pt2 = PassengerTrain.new("P20-00")
    pt3 = PassengerTrain.new("P30-00")
    pt4 = PassengerTrain.new("P40-00")
    pt5 = PassengerTrain.new("P50-00")

    ct1 = CargoTrain.new("C1000")
    ct2 = CargoTrain.new("C2000")
    ct3 = CargoTrain.new("C3000")
    ct4 = CargoTrain.new("C4000")
    ct5 = CargoTrain.new("C5000")
    @trains = [pt1,pt2,pt3,pt4,pt5,ct1,ct2,ct3,ct4,ct5]

    pt1.set_route(r1)
    pt2.set_route(r4)
    pt3.set_route(r2)
    pt4.set_route(r3)

    ct1.set_route(r2)
    ct2.set_route(r3)
    ct3.set_route(r4)
    ct4.set_route(r1)
    ct5.set_route(r3)

   #=======================

    cw1 = CargoWagon.new("CW0001")
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

    ct2.add_wagon(cw2)
    ct2.add_wagon(cw4)
    ct2.add_wagon(cw6)
    ct2.add_wagon(cw8)
    ct2.add_wagon(cw10)

    ct3.add_wagon(cw11)
    ct3.add_wagon(cw12)
    ct3.add_wagon(cw13)

    pt1.add_wagon(pw1)
    pt1.add_wagon(pw3)
    pt1.add_wagon(pw5)

    pt2.add_wagon(pw7)
    pt2.add_wagon(pw9)

    pt3.add_wagon(pw2)
    pt3.add_wagon(pw4)
    pt3.add_wagon(pw6)

    pt4.add_wagon(pw8)
    pt4.add_wagon(pw10)
  end

  def run
    loop do
      system('clear')
      puts "======= MAIN MENU ========= "
      puts "1 - Stations"       #- Создавать станции
      puts "2 - Trains"         #- Создавать поезда
      puts "3 - Routes" #- Создавать маршруты и управлять станциями в нем (добавлять, удалять)
      puts "(Input Number for action or <Enter> key - EXIT ! ) "
      case gets.to_i
      when 1
        @station_actions.station_menu
      when 2
        @trains_actions.train_menu
      when 3
        menu_routes
      else
        break
      end
    end #loop do
    system('clear')
  end

  protected

  def menu_routes
    loop do
      system("clear")
      puts "--     ROUTES MENU    --- #{message_return}"
      puts "1 - Create New Route"       #- Создавать маршрут
      puts "2 - List Routes "  #- Просматривать список маршрутов
      puts "3 - Add Station" #- добавить станцию
      puts "4 - Remove Station" #- удалить станцию
      case gets.to_i
      when 1
        create_new_route
      when 2
        list_routes(@routes)
        gets # pause
      when 3
        menu_for_select_route_and_station("===============> Add Station to Route =========== ", @routes, @stations, true )
      when 4
        menu_for_select_route_and_station("===============> Remove Station from Route =========== ", @routes, @stations, false )
      else
        break
      end
    end #loop
  end

  def create_new_route
    loop do
      system("clear")
      puts "- - - Create New Route - - - "
      first_station = select_station_new_route("1) Select number item from list for First station of Route:")
      break if first_station.to_s.strip.empty?
      puts "====>> Fist station of route: #{first_station.name}"
      last_station = select_station_new_route("2) Select number item from list for Last station of Route:")
      break if last_station.to_s.strip.empty?
      puts "====>> Last station of route: #{last_station.name}"
      new_route = Route.new(first_station, last_station)
      new_route_check_add_to_all(new_route, first_station.name, last_station.name)
      gets #pause
    end # loop
  end

  def new_route_check_add_to_all(new_route, first_name, last_name )
    new_route_string = "Route: #{first_name} -> #{last_name}"
    if create_routes_as_string(@routes).include?(convert_route_to_string(new_route)) # проверить существование маршрута
      puts "This Route: #{new_route_string} Already Exist!"
    else
      @routes << new_route
      puts "This Route: #{new_route_string} Successfully Added to the Routes List!"
    end
  end

  def select_station_new_route(message)
    names_list!(@stations)
    puts message
    indx = gets.to_i - 1
    @stations[indx] if -1 < indx and indx < @stations.size
  end

  def select_index_route(routes)
    only_routes(routes)
    gets.to_i - 1
  end

  def select_station(stations, route, action_add_station )
    puts "Select station for action: \ #{message_return} "
    if action_add_station # case add station to route
      stations_for_selected =  stations - route.stations
      names_list!(stations_for_selected)  # secondary select: select station
    else # case remove station from route
      stations_for_selected =  route.stations
      names_list(stations_for_selected)  # secondary select: select station
    end
    index_station = gets.to_i - 1
    stations_for_selected[index_station] if -1 < index_station && index_station < stations_for_selected.size
  end

  def menu_for_select_route_and_station(name_menu, routes, stations, action_add_station) # сделать проще !
    system("clear")
    puts name_menu unless name_menu.empty?
    loop do
      index_route = select_index_route(routes)
      break unless -1 < index_route && index_route < routes.size
      route_as_string = convert_route_to_string(routes[index_route])
      puts "====>> Selected Route: #{route_as_string} ! "
      current_station = select_station(@stations, routes[index_route], action_add_station)
      break if current_station.nil?
      puts "=====>> Selected station: #{current_station.name}"
      if action_add_station # добавление станции к маршруту
        if routes[index_route].add_station(current_station).nil?
          puts " The station: #{current_station.name} NOT Added to the Route: #{route_as_string} !!! "
        else
          puts "To the Route: #{route_as_string} added  station: #{current_station.name} --> Successfully !"
          puts "New Route: #{convert_route_to_string(routes[index_route])}" # route after add new station
        end
      else # удаление станции из маршрута
        if routes[index_route].delete_station(current_station).nil?
          puts "The station: #{current_station.name} NOT removed from Route: #{route_as_string}"
        else
          puts "The station: #{current_station.name} Successfully removed from Route: #{route_as_string}"
          puts "New Route: #{convert_route_to_string(routes[index_route])}" # route after deleted
        end
      end
      gets # pause
    end #loop do
  end
end # class Interface
