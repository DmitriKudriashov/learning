#  Passenger Wagon
class PassengerWagon < Wagon
  include GlobalValues

  validate :number, :presence
  validate :number, :format, FORMAT_NUMBER_WAGON
  validate :amount, :presence
  validate :amount, :format, /^[\d|.]/

  def initialize(number, places)
    super(number, type: PASSENGER, amount: places)
  end

  def take_place
    fill(1)
  end

  def busy_places
    busy
  end

  def unbusy_places
    unbusy
  end

  def total_places
    amount
  end

  def free_place
    fill(-1)
  end
end
