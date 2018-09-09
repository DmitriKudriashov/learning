class BaseMenuClass

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @route_stations = [] # будет содержать маршруты в виде строк из названий станций
    @wagons = []
    puts "++++++++++++== >>>>>> BaseMenuClass !!!!!!! "
    primary
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

   end

  def make_array_numbers(array_objects) # создать массив названий из объектов, имеющих свойство number
    numbers = []
    array_objects.each { |s| numbers << s.number}
    numbers
  end

  def sort_array_objects_by_name(array_objects)
     array_objects.sort! { |a,b| a.name <=> b.name }# отсортировать по именам станции для дальнейшего использования в списке
  end

  def select_from_names(name_menu, array_items_menu)
    system("clear")
    puts name_menu
    names_list(array_items_menu) # array_items_menu - тут используется массив объектов станций
    selected_number = gets.to_i
  end

  def sort_array_objects_by_number(array_objects)
    array_objects.sort! { |a,b| a.number <=> b.number } # отсортировать по номерам поезда для дальнейшего использования в списке
  end

  def sort_array_objects_by_type(array_objects)
    array_objects.sort! { |a,b| a.type <=> b.type } # отсортировать по номерам поезда для дальнейшего использования в списке
  end

  def numbers_objects_list(array_objects)
    sort_array_objects_by_number(array_objects)
    indx = 0
    array_objects.each do |t|
      indx += 1
      puts "#{indx}. #{t.number}  #{t.type}"
    end
  end

  def names_list(array_objects) # array_objects - objects must be have unique atribute: name
    indx = 0
    array_objects.sort! { |a,b| a.name <=> b.name }
    array_objects.each do  |object|
      indx += 1
      puts "#{indx}. #{object.name}"
    end
  end

  def list_all_numbers(name_menu, array_objects)
   if array_objects.nil? # || array_objects.size == 0
      puts "List is EMPTY!"
   else
      puts name_menu #
      sort_array_objects_by_number(array_objects)
      numbers_objects_list(array_objects)
      puts "======================"
    end
      gets # pause
  end

  def message_return
    "(Select Number or <EnterKey>  for RETURN ) "
  end

  def condition_for_return_previous_menu
    puts "Return to the previous menu? (Y or N): "
    gets.chomp.upcase.include?("Y")
  end

  def create_routes_as_string
    @route_stations = [] # массив маршрутов, каждый из которых это строка из названий станций
    @routes.each do |r|
      stations_names = []
      r.stations.each { |s| stations_names << s.name }
      @route_stations << stations_names * "; "
    end
  end

  def list_routes
    system("clear")
    puts "- - - - List Routes - - - - \n" + message_return
    create_routes_as_string
    indx = 0
    @route_stations.each do |r|
      indx += 1
      print "#{indx}. #{r} \n"
    end
    number_route = gets.to_i
  end

end
