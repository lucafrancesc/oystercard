class Oystercard

  attr_reader :balance, :entry_station
  DEFAULT_BALANCE = 0.00
  CARD_LIMIT = 90.00
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE, limit = CARD_LIMIT, entry_station = nil)
    @balance = balance
    @limit = limit
    @in_use = false
    @entry_station = entry_station
  end

  def top_up(amount)
    fail "Card limit of #{@limit} exceeded" if full?
    fail "Card limit of #{@limit} exceeded" if @balance + amount > @limit
    @balance += amount
    "Your new balance is #{@balance}"
  end

  def in_journey?
    !!entry_station
    # entry_station.nil? ? false : true
  end

  def touch_in(station)
    fail 'Not enough credit' if MIN_FARE > @balance
    @entry_station = station
    @in_use = true
  end

  def touch_out
    @entry_station = nil
    deduct
    @in_use = false
    balance
  end



  private
  def full?
    balance >= @limit
  end

  def deduct(fare = MIN_FARE)
    @balance -= fare
    "Your new balance is #{@balance}"
  end


end
