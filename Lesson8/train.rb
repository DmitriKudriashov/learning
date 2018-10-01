# TRAIN
class Train
  include InstanceCounter
  include Manufacturer

  attr_reader :number, :speed, :route, :wagons, :type

  NUMBER_FORMAT = /^([\da-z]){3}-?\g<-1>{2}$/i

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
  rescue StandardError
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
    check_number_nil
    check_number_empty
    check_number_size
    check_number_format
    check_type_nil
    check_type_size

    true
  end

  def check_number_nil
    raise "Number can't be Nil !" if number.nil?
  end

  def check_number_empty
    raise "Number can't be EMPTY !" if number.to_s.empty?
  end

  def check_number_size
    msg = 'Number should be at least 5 symbols'
    raise msg if number.strip.size.between?(1, 4)
  end

  def check_number_format
    msg = '(where X : 0-9 , a-z , A-Z )'
    msg = "The valid number must be of the form: XXX-XX or XXXXX \n #{msg}"
    raise "Number has invalid format! \n #{msg}" if number !~ NUMBER_FORMAT
  end

  def check_type_nil
    raise "Type can't be nil" if type.nil?
  end

  def check_type_size
    raise 'Type should be at least 5 symbols' if type.size.between?(1, 4)
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
