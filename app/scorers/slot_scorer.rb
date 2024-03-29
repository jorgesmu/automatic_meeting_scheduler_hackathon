class SlotScorer
  THRESHOLD = 0.5

  # This first approach for activaction function take each P(p,t) result and apply an average heuristic
  def initialize(scores)
    @candidate = false
    return if scores.size.zero?
    overall_scoring = scores.sum / scores.size
    @candidate = overall_scoring >= THRESHOLD
  end

  def approved?
    @candidate
  end
end