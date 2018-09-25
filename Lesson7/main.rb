require_relative 'manufacturer'
require_relative 'instance_counter' # 5th task
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'train'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'interface'
require_relative 'menu_stations'
require_relative 'menu_trains'


=begin
  ============================ 6 TASK ===================================
Реализовать проверку (валидацию) данных для всех классов. Проверять основные атрибуты (название, номер, тип и т.п.) на наличие, длину и т.п.
(в зависимости от атрибута):
      - Валидация должна вызываться при создании объекта, если объект невалидный, то должно выбрасываться исключение
      - Должен быть метод valid? который возвращает true, если объект валидный и false - в противном случае.
Релизовать проверку на формат номера поезда. Допустимый формат: три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет)
  и еще 2 буквы или цифры после дефиса.

Убрать из классов все puts (кроме методов, которые и должны что-то выводить на экран), методы просто возвращают значения.
  (Начинаем бороться за чистоту кода).

Релизовать простой текстовый интерфейс для создания поездов (если у вас уже реализован интерфейс, то дополнить его):
    - Программа запрашивает у пользователя данные для создания поезда (номер и другие необходимые атрибуты)
    - Если атрибуты валидные, то выводим информацию о том, что создан такой-то поезд
    - Если введенные данные невалидные, то программа должна вывести сообщение о возникших ошибках и заново запросить данные у пользователя.
      Реализовать это через механизм обработки исключений
  ========================== 7 task =======================================
  Для пассажирских вагонов:
    Добавить атрибут общего кол-ва мест (задается при создании вагона)
    Добавить метод, который "занимает места" в вагоне (по одному за раз)
    Добавить метод, который возвращает кол-во занятых мест в вагоне
    Добавить метод, возвращающий кол-во свободных мест в вагоне.

  Для грузовых вагонов:
    Добавить атрибут общего объема (задается при создании вагона)
    Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
    Добавить метод, который возвращает занятый объем
    Добавить метод, который возвращает оставшийся (доступный) объем

У класса Station:
  написать метод, который принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок.

У класса Train:
 написать метод, который принимает блок и проходит по всем вагонам поезда (вагоны должны быть во внутреннем массиве), передавая каждый объект вагона в блок.

Если нет интерфейса, то в отдельном файле, например, main.rb написать код, который:
Создает тестовые данные (станции, поезда, вагоны) и связывает их между собой.
Используя созданные в рамках задания методы, написать код, который перебирает последовательно все станции и для каждой станции выводит список поездов в формате:
      - Номер поезда, тип, кол-во вагонов
   А для каждого поезда на станции выводить список вагонов в формате:
      - Номер вагона (можно назначать автоматически), тип вагона, кол-во свободных и занятых мест (для пассажирского вагона) или кол-во свободного и занятого объема (для грузовых вагонов).

=end


@menu_main  = Interface.new
@menu_main.start


