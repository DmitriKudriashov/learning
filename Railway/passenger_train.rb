class PassengerTrain < Train

  def initialize(number)
    super(number, "Passenger")
  end

  def add_wagon(wagon)
    super if wagon.type == "Passenger"
  end
end
