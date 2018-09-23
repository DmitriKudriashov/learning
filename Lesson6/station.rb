=begin
---- 3
  Класс Station (Станция):
  Имеет название, которое указывается при ее создании
  Может принимать поезда (по одному за раз)
  Может возвращать список всех поездов на станции, находящиеся в текущий момент
  Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
--- 5th task
  В классе Station (жд станция) создать метод класса all, который возвращает все станции (объекты), созданные на данный момент
--- 6 task
Реализовать проверку (валидацию) данных для всех классов. Проверять основные атрибуты (название, номер, тип и т.п.) на наличие, длину и т.п.
(в зависимости от атрибута):
      - Валидация должна вызываться при создании объекта, если объект невалидный, то должно выбрасываться исключение
      - Должен быть метод valid? который возвращает true, если объект валидный и false - в противном случае.
=end

class Station


  include InstanceCounter # 5th task
  attr_reader :name, :trains
  @@all_stations = [] # 5th task

  def self.all      # 5th task
    @@all_stations
  end

  def initialize(station_name)
    @name = station_name
    validate!              # 6 task
    @trains = []
    @@all_stations << self # 5th task
    register_instance      # 5th task
  end

  def valid?
    validate!
  rescue
    false
  end

  #  Может принимать поезда (по одному за раз)
  def accept_train(train)
    @trains << train unless @trains.map(&:number).include?(train.number)
  end

  #  Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def send_train(train) # здесь train тоже объект, а
    @trains.delete(train)
  end

  def quantuty_trains_by_type(type)
    trains.count { |train| train.type == type }
  end

  protected

  def validate!   #  6 task
    raise "Name station can't be nil !" if name.nil?
    raise "Name station can't be Empty !" if name.strip.empty?
    raise "Name station should be at least 3 symbols" if name.length < 2
    true
  end
end # class

