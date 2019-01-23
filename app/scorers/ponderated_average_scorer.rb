class PonderatedAverageScorer < SlotAttendeeScorer
  def initialize(slot, attendee, features, features_weight, attendee_constraints = [])
    @features = features
    @features_weight = features_weight
    @attendee_constraints = attendee_constraints
    super(slot, attendee)
  end

  protected

  def calculate
    return 0 if @features.size.zero?

    # Attendee constrains
    attendee_constraints.each do |constraint|
      return 0 if constraint.new(@slot, @attendee).enabled?
    end
    
    # Attendee features
    features_result = @features.map { |feature| feature.new(@slot, @attendee).enabled? }
    weights = features_weight.each_with_index { |specific_weight, index| features_result[index] ? features_result[index] * specific_weight : 0 }
    weights.sum /  @features.size
  end
end