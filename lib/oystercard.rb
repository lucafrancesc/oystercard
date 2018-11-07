require_relative 'station'
class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys
  DEFAULT_BALANCE = 0.00
  CARD_LIMIT = 90.00
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE, limit = CARD_LIMIT, entry_station = nil, exit_station = nil)
    @balance = balance
    @limit = limit
    @in_use = nil
    @entry_station = entry_station
    @exit_station = exit_station
    @journeys = []
  end

  def top_up(amount)
    fail "Card limit of #{@limit} exceeded" if full?
    fail "Card limit of #{@limit} exceeded" if @balance + amount > @limit
    @balance += amount
    "Your new balance is #{@balance}"
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    fail 'Not enough credit' if founds?
    @in_use = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @in_use = false
    deduct
    @exit_station = exit_station
    @journeys << { entry_station: @entry_station, exit_station: @exit_station}
    @entry_station, @exit_station = nil
    balance
  end

  private
  def full?
    balance >= @limit
  end

  def founds?
    MIN_FARE > @balance
  end

  def deduct(fare = MIN_FARE)
    @balance -= fare
    "Your new balance is #{@balance}"
  end


end
