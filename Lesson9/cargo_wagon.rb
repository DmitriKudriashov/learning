#  Cargo wagon
class CargoWagon < Wagon
  include GlobalValues

  validate :number, :presence
  validate :number, :format, FORMAT_NUMBER_WAGON
  validate :amount, :presence
  validate :amount, :format, /^[\d|.]/

  def initialize(number, volume)
    super(number, type: CARGO, amount: volume)
  end

  def load_cargo(volume_load)
    fill(volume_load)
  end

  def volume_unfree
    busy
  end

  def volume_free
    unbusy
  end

  def volume
    amount
  end

  def unload_cargo(volume_unload)
    fill(-volume_unload)
  end
end
