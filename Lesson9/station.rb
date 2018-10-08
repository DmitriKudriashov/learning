#  Stations
class Station
  include InstanceCounter
  include GlobalValues
  include Validation

  attr_reader :name, :trains

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name, _options = {})
    @trains = []
    @name = name
    validate!
    # raise "Format name Station Invalid !" unless valid?
    @@all_stations << self
    register_instance
  end

  def train_into_block(trains, block)
    trains.each { |train| block.call(train) }
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def accept_train(train)
    @trains << train unless @trains.map(&:number).include?(train.number)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def quantuty_trains_by_type(type)
    trains.count { |train| train.type == type }
  end

  protected

  def validate!
    # raise unless check_name_presence
    # raise "Station validate! Format name Invalid! " unless check_name_format
    check_name_presence
    check_name_format

    true
  end

  def check_name_presence
    validate :name, :presence
  end

  def check_name_format
   validate :name, :format, FORMAT_NAME_STATION
  end
end
