=begin
  Класс Station (Станция):
  Имеет название, которое указывается при ее создании
  Может принимать поезда (по одному за раз)
  Может возвращать список всех поездов на станции, находящиеся в текущий момент
  Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :name, :trains

  def initialize(station_name)
    @name = station_name
    # поезд - это объект..нам нужен массив для хранения поездов-объектов.
    @trains = []
  end

  #  Может принимать поезда (по одному за раз)
  def accept_train(train)
    @trains << train unless trains.include?(train)
  end

  #  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def send_train(train) # здесь train тоже объект, а
    @trains.delete(train)
  end

  def quantuty_trains_by_type(type)
    trains.count { |train| train.type == type }
  end
end
