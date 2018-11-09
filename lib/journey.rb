require_relative 'station'
require_relative 'oystercard'

class Journey

  MIN_FARE = 1
  FINE = 6

  attr_reader :entry_station, :exit_station

  def initialize
  end

  def entry_station(station)
  end

  def exit_station(station)
  end

  def fare
    FINE
  end

  def complete?

  end

end
