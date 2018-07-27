=begin
  Класс Route (Маршрут):
  Имеет начальную и конечную станцию, а также список промежуточных станций.
  Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
  Может добавлять промежуточную станцию в список
  Может удалять промежуточную станцию из списка
  Может выводить список всех станций по-порядку от начальной до конечной
=end
class Route
  attr_accessor :first, :last
  attr_reader :others, :route

  def initialize(first = "Unknow", last = "Unknow")
    #Имеет начальную и конечную станцию, а также список промежуточных станций.
    @first = first
    @last = last
    @others = []
    make_route
  end

  def make_route        # строится маршрут
    @route = []
    @route << @first
    @route = @route + @others
    @route << @last
  end

  def add(station)  #  Может добавлять промежуточную станцию в список
    @others << station
    make_route
  end

  def delete(station) # Может удалять промежуточную станцию из списка
    @others.delete(station) unless station.empty?
    make_route
  end

  def list #  Может выводить список всех станций по-порядку от начальной до конечной
    route.each { |name_station| puts "station No #{route.index(name_station) + 1}:  #{name_station}" }
  end
end
