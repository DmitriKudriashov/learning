# validation
module Validation
  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, option = nil?)
      msg = "This type: < #{type} > of validation is not supported !"
      raise msg unless [:presence, :format, :type].include?(type)
      @checks ||= {}
      @checks[type] ||= []
      @checks[type] << {name: name, option: option}
    end
  end

  module InstanceMethods

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private
    # max-underthesun say me this algorithm
    def validate!
      valds = self.class.instance_variable_get('@checks')
      # puts" def validate! ====>>> valds=#{valds}"
      [:presence, :format, :type].each do |type|
        method_check = "#{type}_valid"
        unless valds[type].nil?
          valds[type].each do |check|
            value = instance_variable_get("@#{check[:name]}")
            send(method_check, value, check[:option])
          end
        end
      end
    end

    def presence_valid(value, argument)
      raise puts "\nValidation error! Empty  !" if value.to_s.strip.empty?
    end

    def format_valid(value, argument)
      raise puts "\nValidation error! Invalid < #{value} > format!" if value.to_s !~ argument  #  value.to_s --> и числа проверять!method_check
    end

    def type_valid(value, argument)
      raise puts "\nValidation error! Invalid type!" unless value.instance_of?(argument)
    end
  end
end
