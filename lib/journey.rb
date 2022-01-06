class Journey
  attr_reader :start_point, :end_point

  MINIMUM_FARE = 1
  PENALTY_FARE = 1_000_000

  def start_point=(start_point)
    raise 'Journey has already started' if @start_point

    @start_point = start_point
  end

  def end_point=(end_point)
    raise 'Journey has already completed' if @end_point

    @end_point = end_point
  end

  def valid?
    !!(@start_point && @end_point)
  end

  def empty?
    !(start_point || end_point)
  end

  def fare
    return 0 if empty?
    return PENALTY_FARE unless valid?

    MINIMUM_FARE
  end
end
