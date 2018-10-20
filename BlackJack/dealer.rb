# dealer.rb
class Dealer < Gamer
  include GlobalValues

  validate :name, :presence

  def initialize(options = {})
    super(name:  options[:name], type: DEALER)
  end
end

