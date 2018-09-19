=begin
--- 3rd task
  Класс Train (Поезд):
  Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и массив вагоно-объектов, эти данные указываются при создании экземпляра класса
  Может набирать скорость
  Может возвращать текущую скорость
  Может тормозить (сбрасывать скорость до нуля)
  Может возвращать количество вагонов
  Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод добавляет или убирает вагон-объект).
  Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  Может принимать маршрут следования (объект класса Route).
  При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
--- 4th
  При добавлении вагона к поезду, объект вагона должен передаваться как аругмент метода и сохраняться во внутреннем массиве поезда,
  в отличие от предыдущего задания, где мы считали только кол-во вагонов.
  Параметр конструктора "кол-во вагонов" при этом можно удалить.
--- 5th task
   Создать модуль, который позволит указывать название компании-производителя и получать его.
   Подключить модуль к классам Вагон и Поезд

  В классе Train создать метод класса find, который принимает номер поезда (указанный при его создании)
   и возвращает объект поезда по номеру или nil, если поезд с таким номером не найден.
=end

require_relative 'manufacturer.rb'      # не понял я, где надо вставить эти объявления, чтобы только 1 раз их записать,
require_relative 'instance_counter.rb'  # а если тут не написать, то будет ошибка

class Train
  include Manufacturer, InstanceCounter

  attr_reader :number, :speed, :route, :wagons, :type

  @@trains = {} # 5th task

  def self.find(number) # 5th task
    @@trains[:number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = [] # массив вагонов-объектов # 4th task
    @speed = 0
    @@trains[:number] = self # 5th task: add new train into hash: {number => train,... }
    self.register_instance
  end

  # Может принимать маршрут следования (объект класса Route).
  def set_route(route)
    self.route= route # в объекте класса Route, сам маршрут это метод: stations, т.е. собственно массив всех станций
    # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    @current_index = 0 #текущий индекс станции в массиве станций маршрута
    current_station.accept_train(self) unless current_station.nil? # на станцию прибыл поезд
  end

  def add_wagon(wagon)
    @wagons << wagon if !wagon.nil? && @speed == 0 && !@wagons.map(&:number).include?(wagon.number)
  end

  #  Прицепка/отцепка вагонов может осуществляться только если поезд не движется. wagon - object
  def delete_wagon(wagon)
    @wagons.delete(wagon) if @speed == 0
  end

  #  Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def forward_station # возврат след. станции
    @route.stations[@current_index + 1] if current_station != route.last_station
  end

  def current_station  # возврат текущей станции по ТЗ
    @route.stations[@current_index] unless @route.nil?
  end

  def backward_station # возврат предыдущей станции
    @route.stations[@current_index - 1] if current_station != route.first_station
  end

  #  Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def go_forward
    if forward_station #current_station != route.last_station
      current_station.send_train(self)  # поезд убывает с текущей станции
      @current_index += 1   # изменяем индекс на следущий
      current_station.accept_train(self)
    end
  end

  def go_backward
    if backward_station # current_station != route.first_station
      current_station.send_train(self)  # поезд убывает с текущей станции
      @current_index -= 1    # изменяем индекс на предыдущий
      current_station.accept_train(self)
    end
  end

  protected # здесь пока все методы, которые в настоящем проекте явно не требуются.. дальше по ходу будет видно что - куда...
  attr_writer :number, :speed, :route, :wagons # может пригодятся

  def change_speed(increment) # increment: если  положительный, скорость растет , increment: отрицательный скорость падает
    if @speed + increment > 0
      @speed += increment
    else
      @speed = 0  #  наверное неплохо бы и верхнее значение ограничить. но о максимальной скорости в ТЗ ни слова.
    end
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def stop #  Опять не знаю: нужен ли этот стоп ? если в new_speed можно уменьшать скорость?
    @speed = 0
  end
end
