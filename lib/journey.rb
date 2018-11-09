require_relative 'station'
require_relative 'oystercard'

class Journey

  MIN_FARE = 1
  FINE = 6

  attr_reader :journey, :entry_station, :exit_station
  def initialize(journey = nil)
    @journey = []
  end

  def touched_in(station = nil)
    @entry_station = station
    @journey << @entry_station
  end

  def touched_out(station = nil)
    @exit_station = station
    @journey << @exit_station
  end

  def fare
    complete? ? MIN_FARE : FINE
  end

  def complete?
    false if journey.include?nil
  end

end
