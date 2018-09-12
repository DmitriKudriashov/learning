class PassengerWagon < Wagon
  attr_reader :type

  def initialize(number)
    @type = "Passenger"
    super
  end

end
