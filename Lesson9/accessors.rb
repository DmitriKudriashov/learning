# Написать модуль Acсessors, содержащий следующие методы, которые можно вызывать на уровне класса:
#
# 1)метод
#   attr_accessor_with_history
#
#  Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов, при этом сеттер сохраняет все значения инстанс-переменной
#  при изменении этого значения.
# Также в класс, в который подключается модуль должен добавляться инстанс-метод
#   <имя_атрибута>_history
#
#   который возвращает массив всех значений данной переменной.
#
# 2) метод
# strong_attr_accessor
#
#  который принимает имя атрибута и его класс. При этом создается геттер и сеттер для одноименной инстанс-переменной,
#  но сеттер проверяет тип присваемоего значения.
#  Если тип отличается от того, который указан вторым параметром, то выбрасывается исключение.
#  Если тип совпадает, то значение присваивается.

module Accessors
  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        name_sym = "@#{name}".to_sym
        name_history_sym = "@#{name}_history".to_sym
        store = []

        define_method(name) { instance_variable_get(name_sym) }
        define_method("#{name}_history".to_sym) { instance_variable_get(name_history_sym) }
        define_method("#{name}=".to_sym) do |value|
          x = instance_variable_get(name_sym)
          instance_variable_set(name_history_sym, store.push(x)) unless x.nil?
          instance_variable_set(name_sym, value)
        end
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      attr_name_sym = "@#{attr_name}".to_sym

      define_method(attr_name) { instance_variable_get(attr_name_sym) }
      define_method("#{attr_name}=".to_sym) do |value|
        msg = "Different classes! Is required: #{attr_class} != #{value.class} of #{attr_name} "
        raise msg unless value.class.is_a? attr_class

        instance_variable_set(attr_name_sym, value)
      end
    end
  end

  # module InstanceMethods
  # end

  def self.included(receiver)
    receiver.extend  ClassMethods
    # receiver.send :include, InstanceMethods
  end
end

class Test
  include Accessors

  attr_accessor_with_history :a, :b, :s, :d
  strong_attr_accessor :z, String
end
