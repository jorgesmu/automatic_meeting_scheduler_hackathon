class SlotScorer
  THRESHOLD = 0.9

  # This first approach for activaction function take each P(p,t) result and apply an average heuristic
  def initialize(scores)
    @candidate = false
    return if scores.size.zero?
    overall_scoring = array.inject(0){|sum,x| sum + x } / scores.size
    @candidate = overall_scoring >= THRESHOLD
  end

  def candidate?
    @candidate
  end
end