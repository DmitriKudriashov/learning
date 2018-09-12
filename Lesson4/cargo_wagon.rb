class CargoWagon < Wagon
  attr_reader :type, :number

  def initialize(number)
    self.type= "Cargo"
    self.number= number
  end

  protected

  attr_writer :type, :number
end
