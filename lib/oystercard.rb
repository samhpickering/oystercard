class Oystercard
  LIMIT = 90
  MINIMUM = 1

  attr_reader :balance, :station

  def initialize
    @balance = 0
    @station = nil
  end

  def top_up(amount)
    raise "Top up would take card balance over £#{Oystercard::LIMIT} limit" if @balance + amount > LIMIT

    @balance += amount
  end

  def in_journey?
    !!@station
  end

  def tap_in (station)
    fail "Balance is below £#{MINIMUM} minimum" if @balance < MINIMUM

    @station = station
  end

  def tap_out
    deduct(MINIMUM)
    @station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
