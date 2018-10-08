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
  module ClassMethods
    #  этот метод сохраняет названия входящих пар-ров в переменных класса
    # типы входящих пар-ров: Symbol, Symbol, NilClass
    def validate(validation_name, type_validation, type_argument)
      @vldtn_name = validation_name
      @type_vldtn = type_validation
      @vldtn_argument = type_argument
    end
  end

  module InstanceMethods
    attr_reader :value, :argument

    # решил, что неплохо бы иметь инстанс такой метод..
    def validate(validation_name, type_validation, type_argument = nil)
      self.class.validate(validation_name, type_validation, type_argument)
      included_validation!
    end

    def included_valid?
      included_validation!
    rescue StandardError => err
      puts "Class Validation! ERROR: #{err.message}!" # для отладки.. потом надо убрать !
      false
    end

    private

    def select_method_validation
      value_sym = self.class.instance_variable_get('@vldtn_name') # узнаем название проверяемой переменной, т.е. name, number, station..
      @value = instance_variable_get("@#{value_sym}")   # узнаем  значение проверяемой переменной
      @argument = self.class.instance_variable_get('@vldtn_argument')
      type = self.class.instance_variable_get('@type_vldtn')
      select_check = {presence: "presence_valid", format: "format_valid", type: "class_valid"}
      select_check[type]
    end

    def included_validation!
      method_check = select_method_validation
      raise puts "Error: This type validation is missing!" if method_check.nil?
      instance_eval(method_check)
      true
    end

    def presence_valid
      raise puts "Validation error! Empty name !" if value.to_s.strip.empty?
    end

    def format_valid
      raise puts "Validation error! Invalid < #{value} > format!" if value.to_s !~ argument  #  value.to_s --> и числа проверять!
    end

    def class_valid
      raise puts "Validation error! Invalid type!" unless value.instance_of?(argument)
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end
end
