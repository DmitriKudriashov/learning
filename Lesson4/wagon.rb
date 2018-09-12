class Wagon
  attr_reader :number

  def initialize(number)
    number= number
  end

  private
  attr_writer :number

end
