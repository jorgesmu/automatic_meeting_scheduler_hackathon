class PonderatedAverageScorer < SlotAttendeeScorer
  def initialize(slot, attendee, features, features_weights, attendee_constraints = [])
    @features = features
    @features_weights = features_weights
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
    features_result = @features.map { |feature| feature.new(@slot, @attendee).enabled? ? 1 : 0 } [1,0,1,0,1,0,1]
    weights = @features_weights.each_with_index { |specific_weight, index| features_result[index] * specific_weight }
    1 - (weights.sum / @features.size)
  end 
end