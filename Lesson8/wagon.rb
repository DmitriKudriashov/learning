#  Wagon
class Wagon
  include Manufacturer
  include GlobalValues

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
    @busy = busy - qtty unless valid?
    @unbusy = amount - busy
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  protected

  attr_writer :number, :type, :speed, :route, :wagons

  def validate!
    check_number_nil
    check_number_size
    check_type_nil
    check_type_size
    check_amount_nil
    check_amount_value
    check_busy

    true
  end

  def check_number_nil
    raise "Number can't be nil" if number.nil?
  end

  def check_number_size
    raise 'Number should be at least 5 symbols' if number.size < 5
  end

  def check_type_nil
    raise "Type can't be nil" if type.nil?
  end

  def check_type_size
    raise 'Type should be at least 5 symbols' if type.size < 5
  end

  def check_amount_nil
    raise "#{amount_name_by_type} can't be nil!" if amount.nil?
  end

  def check_amount_value
    msg = "#{amount_name_by_type} = #{amount} must be greater than zero!"
    raise msg if amount <= 0
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
