=begin
  Класс Route (Маршрут):
  Имеет начальную и конечную станцию, а также список промежуточных станций.
  Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
  Может добавлять промежуточную станцию в список
  Может удалять промежуточную станцию из списка
  Может выводить список всех станций по-порядку от начальной до конечной
=end
class Route

  def initialize(first = "Unknow", last = "Unknow")
    @first = first
    @last = last
    @others = []
    route
  end

  def route
     @stations = []
     @stations << @first
     @stations = @stations + @others
     @stations << @last
  end

  def others
    @others
  end

  def stations
    @stations
  end


  def fill
    print "First station:"
    @first = gets.chomp
    print "Last station: "
    @last = gets.chomp
    loop do
      print "Input name Other station (put Enter or 'STOP' for exit): "
      new_station = gets.chomp
      break if new_station.empty? || new_station.upcase == 'STOP'
      add(new_station)
    end
    route
  end

  def set_first(first_station)
    @first = first_station
    route
  end

  def set_last(last_station)
    @last = last_station
    route
  end

  def add(other_station_name)
    @others << other_station_name
    route
  end

  def delete(name_remove)
    @others.delete(name_remove) unless name_remove.empty?
    route
  end

  def list
    @stations.each { |name_station| puts "station No #{@stations.index(name_station) + 1}:  #{name_station}" }
  end
end
