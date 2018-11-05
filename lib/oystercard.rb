class Oystercard

  attr_reader :balance
  DEFAULT_BALANCE = 0.00
  CARD_LIMIT = 90.00

  def initialize(balance = DEFAULT_BALANCE, limit = CARD_LIMIT)
    @balance = balance
    @limit = limit
  end

  def top_up(amount)
    fail "Card limit of #{@limit} exceeded" if full?
    @balance += amount
  end

  private
  def full?
    balance >= @limit
  end

end
