=begin
  Класс Train (Поезд):
  Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
  Может набирать скорость
  Может возвращать текущую скорость
  Может тормозить (сбрасывать скорость до нуля)
  Может возвращать количество вагонов
  Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  Может принимать маршрут следования (объект класса Route).
  При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Train
  attr_accessor :number_train, :type_train, :wagons, :speed, :current_number_station, :current_station
  attr_reader   :route

  def initialize(number_train = "Unknow", type_train = "Unknow",  wagons = 0)
    @number_train = number_train
    @type_train = type_train
    @wagons = wagons
    @route = []
    @speed = 0
    @max_speed = 100 # ограничение возможной скорости. может лучше глобальной сделать?
  end

  def set_route=(route_new) # Может принимать маршрут следования (объект класса Route).
    @route = route_new.route # в объекте класса Route, сам маршрут это метод: route, т.е. собственно массив всех станций
    self.current_number_station = 0
    self.current_station = self.route.first
  end

  def previous_current_next_stations # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
    if self.current_number_station == 0
       " #{current_station} -> #{next_station} "
    elsif self.current_number_station + 1 == quantity_stations
       " #{previous_station} -> #{current_station} "
    else
       " #{previous_station} -> #{current_station} -> #{next_station} "
    end
  end

  def quantity_stations
    route.size
  end

  def previous_station
    if self.current_number_station > 0
      route[self.current_number_station - 1]
    else
      current_station # не знаю как тут лучше считать. может пусто поставить?
    end
  end

  def next_station
    if self.current_number_station < quantity_stations
      route[self.current_number_station + 1]
    else
      current_station # не знаю как тут лучше считать. может пусто поставить?
    end
  end

  #Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def move_to_forward_or_backward(forward_or_backward = true)
    if forward_or_backward
      self.current_number_station = self.current_number_station + 1
    else
      self.current_number_station = self.current_number_station - 1
    end
    @current_station = route[current_number_station]
  end

  def puts_parameters
     "Train number: #{number_train},  Type: #{type_train},  quantity wagons: #{wagons}"
  end

  #Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  def change_wagons(plus_minus_one)
     self.wagons = self.wagons + plus_minus_one
     self.wagons = 0 if self.wagons < 0
  end

  def change_speed(new_speed) # Может набирать скорость
    self.speed = new_speed
    self.speed = 0 if new_speed < 0
    self.speed = @max_speed if new_speed > @max_speed
  end

  def stop # Может тормозить (сбрасывать скорость до нуля)
    self.speed = 0
  end
end
