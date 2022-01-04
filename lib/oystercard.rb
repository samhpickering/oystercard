class Oystercard
  attr_reader :balance
  LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Top up would take card balance over £#{Oystercard::LIMIT} limit" if @balance + amount > LIMIT
    
    @balance += amount
  end
end
