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

  #  тут станции -  это класса Station? или все-таки простые строки.
  def initialize(first, last)
  #  Имеет начальную и конечную станцию, а также список промежуточных станций.
    @stations = [first, last]
  end

  def first_station
    @stations.first
  end

  def last_station
    @stations.last
  end
  #  Может добавлять промежуточную станцию в список.
  #  надо из объекта взять имя станции и добавить в массив перед последним элементом
  #  лучше проверить массив на наличие уже этой станции
  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_station(station) # Может удалять промежуточную станцию из списка
    @stations.delete(station) if station != first_station && station != last_station
  end

  def list_stations # Может выводить список всех станций по-порядку от начальной до конечной
    stations.each { |station|  puts "station: #{station.name}" } # случай когда маршрут из объектов
  end
end
