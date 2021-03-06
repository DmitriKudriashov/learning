=begin
--- 5th task
   Создать модуль, который позволит указывать название компании-производителя и получать его.
   Подключить модуль к классам Вагон и Поезд
=end

class Wagon
  include Manufacturer
  attr_reader :number, :type

  def initialize(number, type)
    @number = number
    @type = type
  end

  protected
  attr_writer :number, :type
end
