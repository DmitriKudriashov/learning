class CargoTrain < Train
 attr_reader :type

  def initialize(number)
    super
    @type = type=("Cargo")
  end

  protected
  attr_writer :type

end
