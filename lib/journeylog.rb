require_relative 'station'
require_relative 'oystercard'
require_relative 'journey'

class JourneyLog

attr_reader :entry_station, :exit_station, :journeys

  def initialize(journey = nil)
    @journey = journey
    @journeys = []
  end

  def start(station = nil)
    @journey = Journey.new
    @entry_station = station
    @journey.entry_station(station)
  end

  def finish(station = nil)
    @exit_station = station
    @journey.exit_station(station)
    add_journey
  end

  def cost
    @journey.fare
  end

  private
  def current_journey
    @current_journey ||= Journey.new
  end

  def add_journey
    @journeys << { entry_station: @entry_station, exit_station: @exit_station }
  end

end
