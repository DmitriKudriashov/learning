class CargoTrain < Train

  def initialize(number)
    super(number, "Cargo")
  end

  def add_wagon(wagon)
    super if wagon.type == "Cargo"
  end
end
