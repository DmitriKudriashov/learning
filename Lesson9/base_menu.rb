#  Common methods for menu classes
module BaseMenu
  include GlobalValues

  def listing_block(objects)
    indx = 0
    objects.each do |t|
      indx += 1
      yield(indx, t)
    end
  end

  def make_array_numbers(objects)
    objects.map(&:number)
  end

  def make_array_names(objects)
    objects.map(&:name)
  end

  def select_from_names(array_items_menu)
    names_list!(array_items_menu)
    gets.to_i
  end

  def names_list!(objects)
    names_list(objects) { objects.sort_by!(&:name) }
  end

  def names_list(objects)
    if objects.nil?
      puts 'List is EMPTY!'
    else
      yield if block_given?
      listing_block(objects) { |indx, object| puts "#{indx}. #{object.name}" }
    end
  end

  def list_all_numbers(name_menu, objects)
    if objects.nil?
      puts 'List is EMPTY!'
    else
      puts name_menu
      listing_block(objects) { |indx, object| puts "#{indx}. #{object.number}" }
    end
    gets
  end

  def routes_to_strings(routes)
    routes_strings = []
    routes.each { |route| routes_strings << route_to_string(route) }
    routes_strings
  end

  def route_to_string(route)
    (route.stations.map(&:name) * '; ').upcase
  end

  # return list routs as strings!
  def only_routes(routes)
    puts "- - - - List Routes - - - -   #{message_return} "
    route_stations = routes_to_strings(routes)
    listing_block(route_stations) { |indx, r| puts "#{indx}. #{r}" }
    gets.to_i
  end

  def first_select(name_menu, objects)
    item = selected_from_numbers(name_menu, objects) - 1
    objects[item] if item.between?(0, objects.size - 1)
  end

  def train_and_route(name_menu, objects, routes)
    loop do
      system('clear')
      retval = select_train_body(name_menu, objects, routes)
      break unless retval

      gets
    end
  end

  def select_train_body(name_menu, objects, routes)
    train = first_select(name_menu, objects)
    train.nil? ? false : for_route(train, routes)
  end

  def for_route(train, routes)
    puts ">>Train selected: #{train.number}"
    route = select_route_body(routes)
    route.nil? ? false : train_set_route(train, route)
  end

  def train_set_route(train, route)
    train.assign_route(route)
    puts ">> To the Train: #{train.number} set route: #{route_to_string(route)}"
    true
  end

  def select_route_body(routes)
    indx = only_routes(routes) - 1
    routes[indx] if indx.between?(0, routes.size - 1)
  end

  def selected_from_numbers(name_menu, array_objects)
    puts name_menu unless name_menu.empty?
    listing_block(array_objects) { |i, t| puts "#{i}. #{t.number}  #{t.type}" }
    gets.to_i
  end

  def message_return
    "\n (Select Number or <EnterKey>  for RETURN )"
  end

  def press_enter
    "\n... or press <EnterKey> for RETURN ..."
  end
end
