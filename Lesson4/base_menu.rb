class BaseMenu

  def make_array_numbers(array_objects) # создать массив названий из объектов, имеющих свойство number
    array_objects.map(&:number)
  end

  def make_array_names(array_objects) # создать массив названий из объектов, имеющих свойство name !
    array_objects.map(&:name) # да! прикольно!
  end

  def sort_array_objects_by_name(array_objects)
    array_objects.sort! { |a,b| a.name <=> b.name } unless array_objects.empty?# отсортировать по именам станции для дальнейшего использования в списке
  end

  def select_from_names(name_menu, array_items_menu)
    system("clear")
    puts name_menu
    names_list!(array_items_menu) # array_items_menu - тут используется массив объектов станций
    gets.to_i
  end

  def sort_array_objects_by_number(array_objects)
    if array_objects.empty?
      message_list_is_empty
    else
      array_objects.sort! { |a,b| a.number <=> b.number }  # отсортировать по номерам поезда для дальнейшего использования в списке
    end
  end

  def sort_array_objects_by_type(array_objects)
    if array_objects.empty?
      message_list_is_empty
    else
      array_objects.sort! { |a,b| a.type <=> b.type } unless array_objects.empty? # отсортировать по типам поезда для дальнейшего использования в списке
    end
  end

  def numbers_objects_list(array_objects) # для объекто имеющих свойства: number и type
    unless array_objects.empty?
      sort_array_objects_by_number(array_objects)
      indx = 0
      array_objects.each do |t|
        indx += 1
        puts "#{indx}. #{t.number}  #{t.type}"
      end
    else
      message_list_is_empty
    end
  end

  def names_list!(array_objects) # array_objects - objects must be have unique atribute: name
    if array_objects.nil?
      message_list_is_empty
    else
      array_objects.sort! { |a,b| a.name <=> b.name }
      array_objects_list(array_objects)
    end
  end

  def names_list(array_objects) # array_objects - objects must be have unique atribute: name
    if array_objects.nil?
      message_list_is_empty
    else
      array_objects.sort { |a,b| a.name <=> b.name }
      array_objects_list(array_objects)
    end
  end

  def array_objects_list(array_objects)
    indx = 0
    array_objects.each do  |object|
      indx += 1
      puts "#{indx}. #{object.name}"
    end
  end

  def message_list_is_empty
    puts "List is EMPTY!"
  end

  def list_all_numbers(name_menu, array_objects)
    if array_objects.nil?
      message_list_is_empty
    else
      puts name_menu #
      numbers_objects_list(array_objects)
      puts "======================"
    end
      gets # pause
  end

  def create_routes_as_string(routes)
    routes_stations = [] # массив маршрутов, каждый из которых это строка из названий станций
    routes.each do |route|
      routes_stations <<  convert_route_to_string(route)
    end
    routes_stations
  end

  def convert_route_to_string(route)
    (route.stations.map(&:name) * "; ").upcase
  end

  def list_routes(routes)
    system("clear")
    only_routes(routes)
  end

  def only_routes(routes) # возвращает список маршрутов в виде строк!
    puts "- - - - List Routes - - - -   #{message_return} "
    route_stations = create_routes_as_string(routes)
    indx = 0
    route_stations.each do |r|
      indx += 1
      puts "#{indx}. #{r}"
    end
  end

  def menu_for_select_train_and_route(name_menu, array_objects, routes)
    # used only for array_objects = @trains ! наверное следует тут упростить, или усложнить для более широкого применения в других случаях...не знаю..
    loop do
      selected_number =  selected_from_numbers(name_menu, array_objects) - 1 # first select: select train
      break if selected_number < 0 || selected_number > array_objects.size - 1
      list_routes(routes) # secondary select: select route
      index_route = gets.to_i- 1
      break if index_route < 0 || index_route > routes.size - 1
      array_objects[selected_number].set_route(routes[index_route]) # назначение маршрута поезду
      puts "To the Train: #{array_objects[selected_number].number} set route: #{create_routes_as_string(routes)[index_route]}"
      gets # pause
    end #loop do
  end

  def message_return
    "\n (Select Number or <EnterKey>  for RETURN )"
  end
end
