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
  attr_accessor :speed, :current_station, :wagons
  attr_reader :number, :type, :route, :forward_station, :backward_station #, :current_index

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
  end

  # Может принимать маршрут следования (объект класса Route).
  def set_route=(route)
    @route = route # в объекте класса Route, сам маршрут это метод: stations, т.е. собственно массив всех станций
    @current_station = @route.stations.first # в случае если в маршруте станция - это строка
  end

  #  Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def forward_station
    @forward_station = route.stations[current_index + 1] unless  current_index > route.stations.index(route.stations.last) - 1 # в случае стaнция - string
  end

  def current_index
    @current_index = route.stations.index(current_station) # в случае стaнция - ctring
  end

  def backward_station
    @backward_station = route.stations[current_index - 1] unless current_index < 1  # в случае стaнция - string
  end

  #  Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def go_forward
    @current_station = forward_station
 #   current_index
  end

  def go_backward
    @current_station = backward_station
 #   current_index
  end

  #  Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  #  Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def add_wagon
    self.wagons += 1 unless self.speed > 0 or self.speed > 0
  end

  def delete_wagon
    self.wagons -= 1 unless self.wagons < 1 or self.speed > 0
  end

  def stop # Может тормозить (сбрасывать скорость до нуля)
    self.speed = 0
  end
end
