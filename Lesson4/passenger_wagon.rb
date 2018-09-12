class PassengerWagon < Wagon
  attr_reader :number, :type

  def initialize(number)
    self.type= "Passenger"
    self.number= number
  end

  protected

  attr_writer :number, :type

end
