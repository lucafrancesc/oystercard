require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'
class Oystercard

  attr_reader :balance
  DEFAULT_BALANCE = 0.00
  CARD_LIMIT = 90.00

  def initialize(balance = DEFAULT_BALANCE, limit = CARD_LIMIT, journeylog = JourneyLog.new)
    @balance = balance
    @limit = limit
    @in_use = nil
    @journeylog = journeylog
  end

  def top_up(amount)
    fail "Card limit of #{@limit} exceeded" if full?
    fail "Card limit of #{@limit} exceeded" if @balance + amount > @limit
    @balance += amount
    "Your new balance is #{@balance}"
  end

  def touch_in(station)
    fail 'Not enough credit' if founds?
    @in_use = true
    @journeylog.start(station)
  end

  def touch_out(station)
    @in_use = false
    @journeylog.finish(station)
    @journeylog.journeys
    deduct
    balance
  end

  def in_journey?
    !!@in_use
  end

  def show_journeys
    @journeylog.journeys
  end

  private
  def full?
    balance >= @limit
  end

  def founds?
    Journey::MIN_FARE > @balance
  end

  def deduct
    @balance -= Journey::MIN_FARE
    # @journeylog.cost
    "Your new balance is #{@balance}"
  end


end
