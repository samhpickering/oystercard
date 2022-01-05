class Oystercard
  LIMIT = 90
  MINIMUM = 1

  attr_reader :balance, :history

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    raise "Top up would take card balance over £#{Oystercard::LIMIT} limit" if @balance + amount > LIMIT

    @balance += amount
  end

  def in_journey?
    history.last && history.last[:tap_out].nil?
  end

  def station
    history.last[:tap_in] if in_journey?
  end

  def tap_in (station)
    fail "Balance is below £#{MINIMUM} minimum" if @balance < MINIMUM

    @history.push({tap_in: station, tap_out: nil})
  end

  def tap_out (station)
    fail 'Card cannot be tapped out before it is tapped in' unless in_journey?

    deduct(MINIMUM)
    @history.last[:tap_out] = station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
