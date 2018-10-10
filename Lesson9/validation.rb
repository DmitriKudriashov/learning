# Написать модуль Validation, который:

# Содержит метод класса validate. Этот метод принимает в качестве параметров имя проверяемого атрибута, а
# также тип валидации и при необходимости дополнительные параметры.Возможные типы валидаций:
#    - presence - требует, чтобы значение атрибута было не nil и не пустой строкой. Пример использования:

# validate :name, :presence


#   - format (при этом отдельным параметром задается регулярное выражение для формата). Треубет соответствия значения
# атрибута заданному регулярному выражению. Пример:
# validate :number, :format, /A-Z{0,3}/


#  - type (третий параметр - класс атрибута). Требует соответствия значения атрибута заданному классу. Пример:


# validate :station, :type, RailwayStation

#  Содержит инстанс-метод validate!, который запускает все проверки (валидации), указанные в классе через метод класса validate.
# В случае ошибки валидации выбрасывает исключение с сообщением о том, какая именно валидация не прошла
# Содержит инстанс-метод valid? который возвращает true, если все проверки валидации прошли успешно и false, если есть ошибки валидации.
# К любому атрибуту можно применить несколько разных валидаторов, например
# validate :name, :presence
# validate :name, :format, /A-Z/
# validate :name, :type, String
#  Все указанные валидаторы должны применяться к атрибуту
# Допустимо, что модуль не будет работать с наследниками.

module Validation
  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    #  этот метод сохраняет в массиве названия входящих пар-ров в переменных класса
    # типы входящих пар-ров: Symbol, Symbol, NilClass
    def validate(validation_name, type_validation, type_argument = nil?)
      # method_valid = {presence: 'presence_valid' , format: 'format_valid' , type: 'type_valid'}[type_validation] # упростить !
      indx = [:presence, :format, :type].index(type_validation)
      raise "This type: < #{type_validation} > of validation is not supported !" if indx.nil?
      # method_valid = "#{type_validation}_valid" # так вроде неплохо бы  было сделать..
      @checks ||= []
      @checks << ["#{type_validation}_valid", validation_name, type_argument]
    end
  end

  module InstanceMethods
    attr_reader :value, :argument

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate!
      valds = self.class.instance_variable_get('@checks')
      raise "Validations is nil !" if valds.nil?
      valds.each do |check|
        method_check = check[0].to_sym
        @value = instance_variable_get("@#{check[1]}")
        @argument = check[2]
        send(method_check)
      end
    end

    def presence_valid
      raise puts "Validation error! Empty name !" if value.to_s.strip.empty?
    end

    def format_valid
      raise puts "Validation error! Invalid < #{value} > format!" if value.to_s !~ argument  #  value.to_s --> и числа проверять!method_check
    end

    def type_valid
      raise puts "Validation error! Invalid type!" unless value.instance_of?(argument)
    end
  end
end
