#  Cargo Train
class CargoTrain < Train
  include GlobalValues

  validate :number, :presence
  validate :number, :format, FORMAT_NUMBER_TRAIN

  def initialize(number)
    super(number, type: CARGO)
  end

  def add_wagon(wagon)
    super if wagon.type.eql? CARGO
  end
end
