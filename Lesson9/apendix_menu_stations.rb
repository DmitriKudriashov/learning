#  Apendix for Menu Station
module ApendixMenuStations
  include BaseMenu

  def create_new_station
    puts "- - Create New Station - -  #{message_return}"
    count_loop = 0
    loop do
      count_loop += 1
      new_station = create_station(count_loop)
      break if new_station.nil?

      add_new_station(new_station)
    end
  end

  def add_new_station(new_station)
    name_station = new_station.name.upcase
    stations_string = make_array_names(@stations) * ';'
    if stations_string.upcase.include?(name_station)
      puts "The Station: #{name_station} Already Exists !"
    else
      @stations << new_station
      @stations.sort_by!(&:name)
    end
  end

  def create_station(count_loop)
    puts "#{count_loop}. Name New Station: "
    name_station = gets.chomp.strip
    return if name_station.empty?
    Station.new(name_station)
  rescue StandardError => e
    puts "Create Station Error: #{e.message}"
    retry
  end
end
