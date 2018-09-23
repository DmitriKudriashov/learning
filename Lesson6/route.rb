=begin
  Класс Route (Маршрут):
  Имеет начальную и конечную станцию, а также список промежуточных станций.
  Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
  Может добавлять промежуточную станцию в список
  Может удалять промежуточную станцию из списка
  Может выводить список всех станций по-порядку от начальной до конечной
--- 6 task
  Реализовать проверку (валидацию) данных для всех классов. Проверять основные атрибуты (название, номер, тип и т.п.) на наличие, длину и т.п.
  (в зависимости от атрибута):
        - Валидация должна вызываться при создании объекта, если объект невалидный, то должно выбрасываться исключение
        - Должен быть метод valid? который возвращает true, если объект валидный и false - в противном случае.
=end

class Route
  include InstanceCounter # 5th task
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    validate! #  6 task
    register_instance # 5th task
  end

  def valid?  # 6 task
    validate!
  rescue
    false
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

  protected

  def validate! # 6 task
    validate(first_station)
    validate(last_station)
    raise "The route must have different stations! (In this case first: #{first_station.name}, last: #{last_station.name}) " if first_station.name == last_station.name
    true # думаю true, оставить здесь лучше..чтобы везде было однотипно. тогда valid? наверное следует вообще поместить в родительский класс (у меня BaseMenu)
  end

  def validate(station) # 6 task
    raise "Name station can't be nil !" if station.nil?
    raise "This object: #{station} - is not an instance of the Station class !!!" unless station.class == Station
    raise "Name station can't be Empty !" if station.name.strip.empty?
  end
end # class
