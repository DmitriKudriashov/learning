# module Admin
#   class Train

#   end
# end
module FuelTank

  def fill_tank(level)
    self.fuel_tank = level
  end

  def fuel_level
    self.fuel_tank
  end
  protected
  attr_accessor :fuel_tank
end

# module Debugger
#   module ClassMethods
#     def debug(log)
#      puts "!!! ClassMethods.debug #{log}"
#     end
#   end

#   module InstanceMethods

#     def debug(log)
#       self.class.debug(log)
#     end

#     def print_class
#       puts self.class
#     end
#   end
# end
