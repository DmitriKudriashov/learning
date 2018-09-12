class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = "Passenger"
    @number = number
  end

  def add_wagon(wagon)
    @wagons << wagon if super && @type == wagon.type
  end

end
