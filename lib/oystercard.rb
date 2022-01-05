class Oystercard
  LIMIT = 90
  MINIMUM = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Top up would take card balance over £#{Oystercard::LIMIT} limit" if @balance + amount > LIMIT

    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def tap_in
    fail "Balance is below £#{MINIMUM} minimum" if @balance < MINIMUM
    @in_journey = true
  end

  def tap_out
    deduct(MINIMUM)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
