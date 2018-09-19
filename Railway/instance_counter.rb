=begin
  Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы,
  которые подключаются автоматически при вызове include в классе:
  Методы класса:
         - instances, который возвращает кол-во экземпляров данного класса
  Инастанс-методы:
         - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора.
         При этом данный метод не должен быть публичным.
  Подключить этот модуль в классы поезда, маршрута и станции.
=end

module InstanceCounter
  def self.included(current_class)
    current_class.extend ClassMethods
    current_class.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    def add_instance
       @instances  = @instances.to_i + 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.add_instance
    end
  end
end
