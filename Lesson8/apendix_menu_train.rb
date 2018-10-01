# Apendix for Trains menu
module ApendixMenuTrains
  include GlobalValues

  def create_wagon(type)
    count_loop = 0
    loop do
      count_loop += 1
      wagon = new_wagon(count_loop, type)
      break if wagon.to_s.empty?

      wagons_add(wagon)
    end
  end

  def wagons_add(wagon)
    if make_array_numbers(@wagons).include?(wagon.number)
      puts "This wagon: #{wagon.number} Already Exists! "
    else
      @wagons << wagon
      puts 'Add new wagon Successfully !'
    end
    gets
  end

  def wagon_by_type(type, number, volume)
    type.eql?(CARGO) ? cargo_wgn(number, volume) : pass_wgn(number, volume)
  end

  def pass_wgn(number, places)
    PassengerWagon.new(number, places)
  end

  def cargo_wgn(number, volume)
    CargoWagon.new(number, volume)
  end

  def new_wagon(count_loop, type)
    volume = wagon_volume(count_loop, type).to_f
    wagon_create(type, volume) unless volume.zero?
  end

  def wagon_volume(no_loop, type)
    volume = volume_name(type).upcase
    puts "#{no_loop}. Input #{volume} for New #{type} Wagon :#{press_enter}"
    gets
  end

  def wagon_create(type, volume)
    mess = 'Input number wagon'
    puts "the #{volume_name(type)}: #{volume}, #{mess}:#{press_enter}"
    number = gets.chomp.upcase.strip
    return if number.empty?

    wagon_by_type(type, number, volume)
  rescue StandardError => e
    error_detected(e, number)
    retry
  end

  def error_detected(error, number)
    puts "Error: #{error.message} \n number: #{number}"
    puts 'Enter other number please...!)'
  end

  def menu_up?(number)
    number.empty? ? false : true
  end

  def add_wagon_to_train(name_menu, train)
    puts name_menu
    count_loop = 0
    loop do
      count_loop += 1
      puts "#{count_loop}.=> You must make select item wagon from the list: "
      wagon = wagon_added(train)
      break if wagon.nil?

      train_add_wagon(train, wagon)
      gets
    end
  end

  def train_add_wagon(train, wagon)
    return if train.add_wagon(wagon).nil?

    text = "added wagon #{wagon.number}"
    puts "To the Train: #{train.number} #{text} #{press_enter}"
  end

  def wagon_added(train)
    all_unused_wagons
    wagons = @wagons_unused.select { |w| w.type.eql? train.type }
    item = selected_from_numbers('', wagons) - 1
    wagons[item] if item.between?(0, wagons.size - 1)
  end

  def remove_wagon_from_train(name_menu, train)
    system('clear')
    loop do
      wagons = train.wagons
      item = selected_from_numbers(name_menu, wagons) - 1
      break unless item.between?(0, wagons.size - 1)

      wagon = wagons[item]
      train_delete_wagon(train, wagon)
    end
  end

  def train_delete_wagon(train, wagon)
    return if train.delete_wagon(wagon).nil?

    text = "Removed Successfully from Train: #{train.number}"
    puts "This Wagon: #{wagon.number} #{text} #{press_enter}"
    gets
  end
end
