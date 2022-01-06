require 'journey'

class Oystercard
  LIMIT = 90

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
    history.last && !history.last.valid?
  end

  def station
    history.last.start_point if in_journey?
  end

  def tap_in (station)
    fail "Balance is below £#{Journey::MINIMUM_FARE} minimum" if @balance < Journey::MINIMUM_FARE

    journey = Journey.new
    journey.start_point = station
    @history.push(journey)
  end

  def tap_out (station)
    deduct(Journey::MINIMUM_FARE)
    @history.last.end_point = station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
