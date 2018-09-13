=begin
  Класс Route (Маршрут):
  Имеет начальную и конечную станцию, а также список промежуточных станций.
  Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
  Может добавлять промежуточную станцию в список
  Может удалять промежуточную станцию из списка
  Может выводить список всех станций по-порядку от начальной до конечной
=end
class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  def first_station
    @stations.first
  end

  def last_station
    @stations.last
  end

  def add_station(station)
    @stations.insert(-2, station)  unless @stations.include?(station) #  @stations.map(&:name).include?(station.name) - закоментил.. хотя этот вариант лучше!
  end

  def delete_station(station) # Может удалять промежуточную станцию из списка
    @stations.delete(station) if station != first_station && station != last_station # здесь можно так оставить, т.к. станция -берется из уже готовотого маршрута
  end

  def list_stations # Может выводить список всех станций по-порядку от начальной до конечной
    stations.each { |station|  puts "station: #{station.name}" } # случай когда маршрут из объектов
  end
end
