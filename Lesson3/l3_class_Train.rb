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
  def initialize(number_train = "Unknow", type_train = "Unknow",  wagons = 0)
    @train_properties = { number_train: number_train, type_train: type_train, wagons: wagons}
    @number_train = number_train
    @type_train = type_train
    @quantity_wagons = wagons
    @speed = 0
    @max_velocity = 100
    puts_parameters
  end

  def properties
    @train_properties
  end

  def speed
    @speed
  end

  def number
    @train_properties[:number_train]
  end

  def type
    @train_properties[:type_train]
  end

  def wagons
    @train_properties[:wagons]
  end

  def route
    @route = @train_properties[:route]
  end

  def set_route
    route_new = Route.new
    route_new.fill
    @train_properties[:route] = route_new.stations
    @current_number_station = 0
    route
    @current_station = route[@current_number_station]
  end

  def current_number_station
    @current_number_station
  end


  def previous_current_next_stations
    if current_number_station == 0
       " #{current_station} -> #{next_station} "
    elsif @current_number_station == number_stations
       " #{previous_station} -> #{current_station} "
    else
       " #{previous_station} -> #{current_station} -> #{next_station} "
    end
  end

  def current_station
    @current_station = route[@current_number_station]
  end

  def number_stations
    route.size
  end

  def current_number_station
    @current_number_station
  end

  def previous_station
    if current_number_station > 0
      route[current_number_station - 1]
    else
      current_station # не знаю как тут лучше считать. может пусто поставить?
    end
  end

  def next_station
    if current_number_station < number_stations
      route[current_number_station + 1]
    else
      current_station # не знаю как тут лучше считать. может пусто поставить?
    end
  end

  def move_to_next
    @current_number_station += 1
    current_station
  end

  def move_to_previous
    @current_number_station -= 1
    current_station
  end

  def puts_parameters
     "Train number: #{number},  Type: #{type},  quantity wagons: #{wagons}"
  end

  def puts_speed
     "Current speed: #{speed}"
  end

  def change_wagons(increase)
    if speed == 0
     @wagons += increase
    else
     puts "Train in motion !"
    end
  end

  def add_wagon
    change_wagons(1)
  end

  def remove_wagon
    change_wagons(-1)
  end

  def change_speed(increase)
    @speed += increase
    @speed = 0 if @speed < 0
    @speed = @max_velocity if @speed > @max_velocity
    puts_speed
  end

  def add_speed(value)     # хотя скорее всего это лишнее
    change_speed(value)
  end

  def reduce_speed(value)  # хотя скорее всего это лишнее
     change_speed(-value)
  end

  def stop_train
    @speed = 0
  end
end
