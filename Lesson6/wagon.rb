=begin
--- 5th task
   Создать модуль, который позволит указывать название компании-производителя и получать его.
   Подключить модуль к классам Вагон и Поезд
=end

class Wagon
  include Manufacturer

  attr_reader :number, :type

  @@instances = 0

  def initialize(number, type)
    @number = number
    @type = type
    validate!  #  6 task
  end

  def valid? # 6 task
    validate!
  rescue
    false
  end

  protected
  attr_writer :number, :type
  attr_writer :number, :speed, :route, :wagons # может пригодятся

  def validate!   #  6 task
    raise "Number can't be nil" if number.nil?
    raise "Number should be at least 5 symbols" if number.length < 5 # пока так сделаю..никаких особых условий на номер вагона в ТЗ нет
    raise "Type can't be nil" if type.nil?
    raise "Type should be at least 5 symbols" if type.length < 5 # я расчитываю на то, что тип поезд может быть у нас только грузовой или пассажирский..другие типы нам неизвестны.
    true
  end
end
