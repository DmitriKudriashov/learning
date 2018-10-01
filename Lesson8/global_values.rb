module GlobalValues
  CARGO = 'Cargo'.freeze
  PASSENGER = 'Passenger'.freeze

  def volume_name(type)
    type.eql?(CARGO) ? 'volume' : 'places'
  end
end
