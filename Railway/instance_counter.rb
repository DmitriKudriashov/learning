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
  def self.included(current_class) # не очень понятно: а зачем тут вообще предусмотрен входящий параметр?
                                   # интересно....где-то делается вызов этого метода с наперед заданным другим параметром, а не текущим классом,
                                   # в котором это используется?
    current_class.extend ClassMethods
    current_class.send :include, InstanceMethods
  end

  module ClassMethods
     @@instances = 0 #  не могу понять, где надо эту переменную класса объявлять..если здесь не вставить, то ClassMethods ее не знает..

    def instances_plus #(instances) пробовал парамером передавать ...тоже не то..
       @@instances  += 1
    end

    def instances
      @@instances
    end

  end

  module InstanceMethods

    protected

    def register_instance #(instances) пробовал парамером передавать ...тоже не то..
      self.class.send :instances_plus #, instances
      # instances += 1
    end
  end
end
