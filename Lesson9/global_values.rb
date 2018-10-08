module GlobalValues
  CARGO = 'Cargo'.freeze
  PASSENGER = 'Passenger'.freeze
  FORMAT_NUMBER_WAGON = /^(\d|[A-Z]){3,}$/
  FORMAT_NUMBER_TRAIN = /^([\da-z]){3}-?\g<-1>{2}$/i
  FORMAT_TYPE = /^[a-z]{5,}/i
  FORMAT_NAME_STATION = /^([A-Z]|\d|\s|-){3,}\g<-1>{1,}$/i

  def volume_name(type)
    type.eql?(CARGO) ? 'volume' : 'places'
  end
end
