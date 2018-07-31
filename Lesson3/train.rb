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
  attr_accessor :current_index
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

  def set_station(index_station) # вспомогательный метод для определения станции по индексу в массиве
     @route.stations[index_station] unless index_station.nil?
  end

  #  Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def forward_index
     # @current_index + 1 unless @current_index > route.stations.size - 2
    @current_index < route.stations.size - 1 ? @current_index + 1 : route.stations.size - 1 # не должен превышать максимальный индекс массива
    # тоже как тут лучше не знаю.. так или иначе- все должно в дальнейшем коде обрабатываться, где этот ответ будет использоваться
  end

  def forward_station
    set_station(forward_index)
  end

  def current_station  # метод нужен для контроля текущей станции
    set_station(@current_index)
  end

  def backward_index
    # @current_index - 1 unless @current_index < 1 # может вернуть пусто
    @current_index > 0 ? @current_index -1 : 0 # чтобы пусто не возвращалось! Хотя точно и не знаю как лучше..все зависит от дальнейшей обработки этой станции!
  end

  def backward_station
    set_station(backware_index)
  end

  #  Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def go_forward
    @current_index = forward_index
    current_station
  end

  def go_backward
    @current_index = backward_index
    current_station
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
