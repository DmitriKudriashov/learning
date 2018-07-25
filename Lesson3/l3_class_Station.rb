=begin
  Класс Station (Станция):
  Имеет название, которое указывается при ее создании
  Может принимать поезда (по одному за раз)
  Может возвращать список всех поездов на станции, находящиеся в текущий момент
  Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  def initialize(name_station = "City N")
   @trains = {}  # по условию - нужен поезд,как я понимаю, что это идентификационный номер. и тип поезда. {number_train1 => type_train, number_train2 => type_train, ...}
   @name_station = name_station
    puts "Station: #{@name_station} "
  end

  def station
    @station
  end

  def trains
    @trains
  end

  def add_train(number_train, type_train)
    @trains[number_train] = type_train
  end

  def delete_train(number_train)
    @trains.delete(number_train)
  end

  def list_trains
    @trains.each { |number_train, type_train|  puts "#{number_train}   #{type_train}"}
  end

  def quantty_type_trans(type_train)
    @trains.values.count(type_train)
  end

  def train_types_list
    @trains.invert.each { |type_train, number_train| puts "#{type_train}: #{Station.quantty_type_trans(type_train)}"}
  end
end
