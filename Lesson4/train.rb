=begin
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
=end

class Train
  attr_reader :number, :speed, :route, :wagons, :type

  def initialize(number)
    @number = number
    @wagons = [] # массив вагонов-объектов
    @speed = 0
  end

  # Может принимать маршрут следования (объект класса Route).
  def set_route(route)
    @route = route # в объекте класса Route, сам маршрут это метод: stations, т.е. собственно массив всех станций
    # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    @current_index = 0 #текущий индекс станции в массиве станций маршрута
    current_station.accept_train(self) unless current_station.nil? # на станцию прибыл поезд
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

  #  Прицепка/отцепка вагонов может осуществляться только если поезд не движется. wagon - object
  def add_wagon(wagon)

    if !wagon.nil? && @speed == 0 && @type == wagon.type && !@wagons.include?(wagon) # наверное еще нужно ограничение на кол-во всех вагонов знать!
       @wagons << wagon
      true
    else
     # puts " Speed = #{@speed}; Type: #{@type}; Wagon type: #{wagon.type}; @wagons.include?(wagon) = #{@wagons.include?(wagon)}"  # for debug only
      false
    end
  end

  def delete_wagon(wagon)
    if @speed == 0
      @wagons.delete(wagon)
      true
    else
      false
    end
  end

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

  protected

  attr_writer :type

end
