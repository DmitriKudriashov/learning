# TRAIN
class Train
  include InstanceCounter
  include Manufacturer
  include GlobalValues
  include Validation

  attr_reader :number, :speed, :route, :wagons, :type

  @@trains = {}

  def initialize(number, options = {})
    @number = number
    @type = options[:type]
    validate!
    @wagons = []
    @speed = 0
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def wagon_into_block(wagons, block)
    wagons.each { |wagon| block.call(wagon) }
  end

  def valid?
    validate!
  rescue
    false
  end

  def assign_route(route)
    self.route = route
    @current_index = 0
    current_station.accept_train(self) unless current_station.nil?
  end

  def add_wagon(wagon)
    return if wagon.nil?

    wagon_not_exist = !@wagons.map(&:number).include?(wagon.number)
    @wagons << wagon if @speed.zero? && wagon_not_exist
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
  end

  def forward_station
    @route.stations[@current_index + 1] unless current_station.eql? route.last_station
  end

  def current_station
    @route.stations[@current_index] unless @route.nil?
  end

  def backward_station
    @route.stations[@current_index - 1] unless current_station.eql? route.first_station
  end

  def go_forward
    return if forward_station.nil?

    current_station.send_train(self)
    @current_index += 1
    current_station.accept_train(self)
  end

  def go_backward
    return if backward_station.nil?

    current_station.send_train(self)
    @current_index -= 1
    current_station.accept_train(self)
  end

  protected

  attr_writer :number, :speed, :route, :wagons

  def validate!
    check_number_presence
    check_number_format
    check_type_presence
    check_type_format

    true
  end

  def check_number_presence
    validate :number, :presence
  end

  def check_number_format
    validate :number, :format, FORMAT_NUMBER_TRAIN
  end

  def check_type_presence
    validate :type, :presence
  end

  def check_type_format
    validate :type, :format, FORMAT_TYPE
  end

  def change_speed(increment)
    if @speed + increment > 0
      @speed += increment
    else
      @speed = 0
    end
  end

  def stop
    @speed = 0
  end
end
