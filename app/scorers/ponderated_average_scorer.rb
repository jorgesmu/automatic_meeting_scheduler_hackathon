class PonderatedAverageScorer < SlotAttendeeScorer
  def initialize(slot, attendee, features, attendee_constraints = [])
    @features = features
    @attendee_constraints = attendee_constraints
    super(slot, attendee)
  end

  protected

  def calculate
    return 0 if @features.size.zero?

    # Attendee constrains
    @attendee_constraints.each do |constraint|
      return 0 if constraint.new(@slot, @attendee).enabled?
    end

    # Attendee features
    features_result = @features.sum { |feature, weight| feature.new(@slot, @attendee).enabled? ? weight : 0 }
    weights = features_result.sum
    maximum_score = @features.sum { |_, weight| weight}
    1 - (weights.sum / maximum_score)
  end
end