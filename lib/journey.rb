require_relative 'station'
require_relative 'oystercard'

class Journey

  MIN_FARE = 1
  FINE = 6

  attr_reader :touch_in, :touch_out, :entry_station, :exit_station, :journeys

  def initialize(touch_in = nil, touch_out = nil, entry_station = nil, exit_station = nil)
    @touch_in = touch_in
    @touch_out = touch_out
    @journeys = []
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def touched_in(entry_station = (no_argument_passed = true; true))
    no_argument_passed ? @entry_station = 'No touch_in record' : @entry_station = entry_station
    no_argument_passed ? (@touch_in = false) : (@touch_in = true)
  end

  def touched_out(exit_station = (no_argument_passed = true; true))
    no_argument_passed ? @exit_station = 'No touch_out record' : @exit_station = exit_station
    no_argument_passed ? (@touch_out = false) : (@touch_out = true)
  end

  def fare
    complete? ? MIN_FARE : FINE
  end

  def finish
    @journeys << { entry_station: @entry_station, exit_station: @exit_station }
  end

  def complete?
    !!(@touch_in && @touch_out)
  end
end
