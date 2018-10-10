# Passengers
class PassengerTrain < Train
  include GlobalValues

  validate :number, :presence
  validate :number, :format, FORMAT_NUMBER_TRAIN

  def initialize(number)
    super(number, type: PASSENGER)
  end

  def add_wagon(wagon)
    super if wagon.type.eql? PASSENGER
  end
end
