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
    number_validate! #  6 task
    @type = type
    type_validate!  #  6 task
  end

  def valid? # 6 task
    number_valid? && type_valid?
  end

  def number_valid? # 6 task
    number_validate!
  rescue
    false
  end

  def type_valid?  #  6 task
    type_validate!
  rescue
    false
  end

  protected
  attr_writer :number, :type
  attr_writer :number, :speed, :route, :wagons # может пригодятся

  def type_validate!   #  6 task
    raise "Type can't be nil" if type.nil?
    raise "Type should be at least 5 symbols" if type.length < 5 # я расчитываю на то, что тип поезд может быть у нас только грузовой или пассажирский..другие типы нам неизвестны.
    true
  end

  def number_validate!   #  6 task
    raise "Number can't be nil" if number.nil?
    raise "Number should be at least 5 symbols" if number.length < 5 # пока так сделаю..никаких особых условий на номер вагона в ТЗ нет
    true
  end
end
