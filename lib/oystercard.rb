class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys
  DEFAULT_BALANCE = 0.00
  CARD_LIMIT = 90.00
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE, limit = CARD_LIMIT, entry_station = nil, exit_station = nil)
    @balance = balance
    @limit = limit
    @in_use = false
    @entry_station = entry_station
    @exit_station = exit_station
    @journeys = { 0 => [] }
  end

  def top_up(amount)
    fail "Card limit of #{@limit} exceeded" if full?
    fail "Card limit of #{@limit} exceeded" if @balance + amount > @limit
    @balance += amount
    "Your new balance is #{@balance}"
  end

  def in_journey?
    # !!entry_station
    @in_use
  end

  def touch_in(station)
    fail 'Not enough credit' if founds?
    @in_use = true
    @journeys[@journeys.keys.last.next] = [@entry_station = station]
  end

  def touch_out(station)
    @in_use = false
    deduct
    @journeys.values.last.push(@exit_station = station)
    @entry_station = nil
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
