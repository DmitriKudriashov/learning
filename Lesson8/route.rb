#  Route
class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    validate!
    register_instance
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def first_station
    @stations.first
  end

  def last_station
    @stations.last
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_station(station)
    return if station.eql?(first_station) || station.eql?(last_station)

    @stations.delete(station)
  end

  def list_stations
    stations.each { |station| puts "station: #{station.name}" }
  end

  protected

  def validate!
    validate(first_station)
    validate(last_station)
    check_first_eql_last

    true
  end

  def check_first_eql_last
    mssg = 'The route must have different stations! (In this case first:'
    mssg = "#{mssg} #{first_station.name}, last: #{last_station.name})"
    raise mssg.to_s if first_station.name.eql? last_station.name
  end

  def validate(station)
    raise "Name station can't be nil !" if station.nil?

    station_class_check(station)
    station_not_empty_check(station)
  end

  def station_class_check(station)
    mssg = "This object: #{station} - is not an instance of the Station class!"
    raise mssg unless station.class.eql?(Station)
  end

  def station_not_empty_check(station)
    raise "Name station can't be Empty !" if station.name.strip.empty?
  end
end
