# Passengers
class PassengerTrain < Train
  def initialize(number)
    super(number, type: PASSENGER)
  end

  def add_wagon(wagon)
    super if wagon.type.eql? PASSENGER
  end
end
