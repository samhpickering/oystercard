class Oystercard
  attr_reader :balance
  LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Top up would take card balance over £#{Oystercard::LIMIT} limit" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def tap_in
    @in_journey = true
  end

  def tap_out
    @in_journey = false
  end
end
