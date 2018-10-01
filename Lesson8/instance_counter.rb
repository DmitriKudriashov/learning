# => Module Counter calculate instanses
module InstanceCounter
  def self.included(current_class)
    current_class.extend ClassMethods
    current_class.send :include, InstanceMethods
  end
  # Class methods
  module ClassMethods
    attr_reader :instances

    def add_instance
      @instances = @instances.to_i + 1
    end
  end
  # Instances counter
  module InstanceMethods
    protected

    def register_instance
      self.class.add_instance
    end
  end
end
