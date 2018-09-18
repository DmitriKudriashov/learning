=begin
--- 5th task
   Создать модуль, который позволит указывать название компании-производителя и получать его.
   Подключить модуль к классам Вагон и Поезд
=end
require_relative 'manufacturer'

class Wagon
  include Manufacturer

  attr_reader :number, :type

  @@instances = 0

  def initialize(number, type)
    @number = number
    @type = type
  end

  protected
  attr_writer :number, :type
  attr_writer :number, :speed, :route, :wagons # может пригодятся
end
