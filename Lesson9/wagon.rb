#  Wagon
class Wagon
  include Manufacturer
  include Validation

  attr_reader :number, :type, :amount, :busy, :unbusy

  @@instances = 0

  def initialize(number, options = {})
    @number = number
    @type = options[:type]
    @amount = options[:amount]
    validate!
    @busy = 0
    @unbusy = amount
  end

  def fill(qtty)
    @busy = busy + qtty
    @busy = busy - qtty unless valid_instance?
    @unbusy = amount - busy
  end

  def valid_instance?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  attr_writer :number, :type, :speed, :route, :wagons

  # def validate!
  #   check_number_presence
  #   check_number_format
  #   check_type_presence
  #   check_amount_presence
  #   check_amount_value
  #   check_busy
  # end

  # def check_number_presence
  #   self.class.validate :number, :presence
  # end

  # def check_number_format
  #   self.class.validate :number, :format, FORMAT_NUMBER_WAGON
  # end

  # def check_type_presence
  #   self.class.validate :type, :presence
  # end

  # def check_type_format
  #   self.class.validate :type, :format, FORMAT_TYPE
  # end

  def check_amount_presence
    self.class.validate :amount, :presence
  end

  def check_amount_value
    self.class.validate :amount, :format, /^[\d|.]/
  end

  def check_busy
    raise "Busy = #{busy}, can't be less than zero!" if busy.to_f < 0

    msg = "Busy = #{busy}, can't be greater than #{amount}!"
    raise msg if busy.to_f > amount
  end

  def amount_name_by_type
    volume_name(type).capitalize
  end
end
