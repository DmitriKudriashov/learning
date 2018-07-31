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
  attr_reader :number, :speed, :type, :route, :wagons,  :current_index # :current_index нужен  для просмотра в irb

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  # Может принимать маршрут следования (объект класса Route).
  def set_route(route)
    @route = route # в объекте класса Route, сам маршрут это метод: stations, т.е. собственно массив всех станций
    # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    @current_index = 0 #текущий индекс станции в массиве станций маршрута
    route.stations[0].accept_train(self) # на станцию прибыл поезд
  end

  #  Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def forward_station # возврат след. станции
    @route.stations[@current_index + 1] unless
  end

  def current_station  # возврат текущей станции по ТЗ
    @route.stations[@current_index]
  end

  def backward_station # возврат предыдущей станции
    @route.stations[@current_index - 1] unless @current_index < 1
  end

  #  Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def go_forward
    if  @current_index < route.stations.size - 2
      @current_station.send_train(self) # поезд убывает с текущей станции
      @current_index += 1   # изменяем индекс на следущий
      @route.stations[@current_index].accept_train(self)
      @current_station = @route.stations[@current_index] # поставил последней срочкой метода, чтобы метод возвращал  станцию на которую прибыл поезд
  # else
  #   @route.stations[@current_index] # current_station # надо чтобы метод вернул текущую станцию
    end
  end

  def go_backward
    if @current_index > 0
      @current_station.send_train(self)  # поезд убывает с текущей станции
      @current_index -= 1    # изменяем индекс на предыдущий
      @route.stations[@current_index].accept_train(self) #
      @current_station = @route.stations[@current_index] # поставил последней срочкой метода, чтобы метод возвращал  станцию на которую прибыл поезд
    #  else
    #  @route.stations[@current_index] # current_station  # надо чтобы метод вернул текущую станцию
    end
  end

  #  Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  #  Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def add_wagon
    @wagons += 1 unless @speed > 0
  end

  def delete_wagon
    @wagons -= 1 unless @wagons < 1 || @speed > 0
  end

  def new_speed(new_value)
    if new_value > 0   # специально использую условный оператор . чтобы задать скорость
      @speed = new_value
    else
      @speed = 0
    end
  end

  def stop # Может тормозить (сбрасывать скорость до нуля)
    @speed = 0
  end
end
