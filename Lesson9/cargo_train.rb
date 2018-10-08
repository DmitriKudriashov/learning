#  Cargo Train
class CargoTrain < Train
  include GlobalValues

  def initialize(number)
    super(number, type: CARGO)
  end

  def add_wagon(wagon)
    super if wagon.type.eql? CARGO
  end
end
