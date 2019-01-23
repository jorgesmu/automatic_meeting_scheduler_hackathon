class SlotAttendeeScorer

  # This first approach for activaction function take each P(p,t) result and apply an average heuristic
  def initialize(slot, attendee)
    @slot = slot
    @attendee = attendee
  end

  def score
    @score ||= calculate
  end

  protected

  def calculate
    raise('Not implemented yet')
  end
end