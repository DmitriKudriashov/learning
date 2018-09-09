class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = type=("Passenger")
  end

  protected
  attr_writer :type

end
