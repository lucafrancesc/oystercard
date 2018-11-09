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
    @journey << @entry_station if station != nil
  end

  def touched_out(station = nil)
    @exit_station = station
    @journey << @exit_station if station != nil
  end

  def fare
    !!complete? ? MIN_FARE : FINE
  end

  def complete?
    return true if @journey.count == 2
  end

end
