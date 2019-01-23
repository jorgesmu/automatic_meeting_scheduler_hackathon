class SlotAttendeeScorer

  # This first approach for activaction function take each P(p,t) result and apply an average heuristic
  def initialize(slot, attendee)
    @slot = slot
    @attende = attendee
  end

  def score
    @score ||= calculate
  end
end