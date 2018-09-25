=begin
--- 5th task
   Создать модуль, который позволит указывать название компании-производителя и получать его.
   Подключить модуль к классам Вагон и Поезд
--- 7 task
    Добавить атрибут общего объема (задается при создании вагона)
    Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
    Добавить метод, который возвращает занятый объем
    Добавить метод, который возвращает оставшийся (доступный) объем
=end

class Wagon
  include Manufacturer

  attr_reader :number, :type, :amount, :busy, :unbusy

  @@instances = 0

  def initialize(number, type, amount)
    @number = number
    @type = type
    @amount = amount
    validate!  #  6 task
    @busy = 0  #  7 task
    @unbusy = amount # 7 task
  end

  def fill(qtty)  # заполнение
    @busy = busy + qtty
    @busy = busy - qtty unless valid? # надо вернуть предыдущее значение busy, если проверка не прошла !
    @unbusy = amount - busy
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
    raise "Amount can't be nil!" if amount.nil?
    raise "Amount = #{amount} must be greater than zero!" if amount <= 0
    raise "Busy = #{busy}, can't be less than zero!" if busy.to_i < 0
    raise "Busy = #{busy}, can't be greater than #{amount}!" if busy.to_i > amount
    true
  end
end
