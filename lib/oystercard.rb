class Oystercard

  attr_reader :balance
  DEFAULT_BALANCE = 0.00
  CARD_LIMIT = 90.00
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE, limit = CARD_LIMIT)
    @balance = balance
    @limit = limit
    @in_use = false
  end

  def top_up(amount)
    fail "Card limit of #{@limit} exceeded" if full?
    fail "Card limit of #{@limit} exceeded" if @balance + amount > @limit
    @balance += amount
  end

  def deduct
    @balance -= MIN_FARE
  end

  def in_journey?
    @in_use
  end

  def touch_in
    fail 'Not enough credit' if MIN_FARE > @balance
    @in_use = true
  end

  def touch_out
    deduct
    @in_use = false
  end

  private
  def full?
    balance >= @limit
  end

end
