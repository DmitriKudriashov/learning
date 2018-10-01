#  Stations
class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name, _options = {})
    @name = name
    validate!
    @trains = []
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
    check_name_nil
    check_name_empty
    check_name_size

    true
  end

  def check_name_nil
    raise "Name station can't be nil !" if name.nil?
  end

  def check_name_empty
    raise "Name station can't be Empty !" if name.strip.empty?
  end

  def check_name_size
    raise 'Name station should be at least 3 symbols' if name.size < 2
  end
end
