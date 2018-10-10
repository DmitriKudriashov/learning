require_relative 'global_values'
require_relative 'validation'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'base_menu'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'train'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'change_route'
require_relative 'primary'
require_relative 'interface'
require_relative 'apendix_menu_stations'
require_relative 'menu_stations'
require_relative 'apendix_menu_train'
require_relative 'menu_trains'

class TestingValidation
  include Validation
  attr_accessor :name_check, :number, :station
  validate :name_check, :presence
  validate :number, :format, /[A-Z]{3}/
  validate :station, :type, Station

  # def test_name
  #   # self.class.validate :name_check, :presence
  #   puts "Name valid? = #{valid?}"
  # end

  # def test_format
  #   # self.class.validate :number, :format, /[A-Z]{3}/
  #   puts  "NUMBER valid? = #{valid?}"
  # end

  # def test_station
  #   # self.class.validate :station, :type, Station
  #   puts  "STATION class valid? = #{valid?}"
  # end
end

if __FILE__ == $PROGRAM_NAME
  obj_test = TestingValidation.new
  puts "obj_test = #{obj_test}"
  # puts "====== 1 ======= "
  # obj_test.name_check = 'name_to_test'
  # obj_test.number = 'AAA'
  # obj_test.station = Station.new('XXXXXX')
  # puts obj_test.valid? ? "OK" : "BAD"

  # puts "====== 2 ======= "

  # obj_test.name_check = ''
  # obj_test.number = 'AAA'
  # obj_test.station = Station.new('XXXXXX')
  # puts obj_test.valid? ? "OK" : "BAD"


  # puts "====== 3 ======= "

  # obj_test.name_check = 'new name'
  # obj_test.number = '111'
  # obj_test.station = Station.new('XXXXXX')
  # puts obj_test.valid? ? "OK" : "BAD"

  # puts "====== 4 ======= "

  # obj_test.name_check = 'new name'
  # obj_test.number = 'AAA'
  # obj_test.station =  Station.new('XXXXXX')
  # puts obj_test.valid? ? "OK" : "BAD"



 puts "====== 5 ======= "

  obj_test.name_check = 'new name'
  obj_test.number = 'AAA'
  obj_test.station =  PassengerTrain.new('P1000')
  puts obj_test.valid? ? "OK" : "BAD"

  # puts "====== 2.1 ======= >>>>>>>>>>>. Test Format <<<<<<<<<"
  # obj_test.number = 'AAA'
  # puts " 1) obj_test.number = #{obj_test.number}"
  # # obj_test.test_format

  # puts "====== 2.2 ======= >>>>>>>>>>>. Test Format <<<<<<<<<"
  # obj_test.number = '111'
  # puts " 2) obj_test.number = #{obj_test.number}"
  # obj_test.test_format

  # obj_test.name_check = 'name_to_test'
  # puts " 1) obj_test.name_check = #{obj_test.name_check}"
  # obj_test.test_name

  # puts "====== 1.2 ======= >>>>>>>>>>>. Test Name <<<<<<<<<<<<"
  # obj_test.name_check = ''
  # puts " 2) obj_test.name_check = #{obj_test.name_check}"
  # obj_test.test_name


  # puts "====== 3.1 ======= >>>>>>>>>>>. Station class <<<<<<<"

  # obj_test.station = Station.new('XXXXXX')
  # puts "obj_test.station = Station.new('XXXXXX')"
  # obj_test.test_station

  # puts "====== 3.2 ======= >>>>>>>>>>>. Station class <<<<<<<"

  # obj_test.station  = CargoTrain.new('C1000')
  # puts "obj_test.station  = CargoTrain.new('C1000')"
  # obj_test.test_station
end
