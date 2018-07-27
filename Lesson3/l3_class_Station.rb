=begin
  Класс Station (Станция):
  Имеет название, которое указывается при ее создании
  Может принимать поезда (по одному за раз)
  Может возвращать список всех поездов на станции, находящиеся в текущий момент
  Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_accessor :name
  attr_reader :trains

  def initialize(station_name = "City N")
   # по условию - поезд, как я понимаю: нужен хеш. где номер поезда - ключ, а значение - тип поезда
   @trains = {}
   @name = station_name
  end

  #  Может принимать поезда (по одному за раз)
  def add_train(number_train, type_train)
    @trains[number_train] = type_train
  end

  #  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def delete_train(number_train)
    @trains.delete(number_train)
  end

  #  Может возвращать список всех поездов на станции, находящиеся в текущий момент
  def list
    @trains.each { |number_train, type_train|  puts "Train No: #{number_train}, type:  #{type_train}"}
  end

  #  Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def list_quantity_by_type
    @trains.invert.each { |type_train, number_train| puts "#{type_train}: #{trains.values.count(type_train)}"}
  end
end
