class PonderatedAverageScorer < SlotAttendeeScorer
  def initialize(slot, attendee, features, attendee_constraints = [])
    @features = features
    @attendee_constraints = attendee_constraints
    super(slot, attendee)
  end

  def calculate
    return 0 if @features.size.zero?

    # Attendee constrains
    @attendee_constraints.each do |constraint|
      return 0 if constraint.new(@slot, @attendee).enabled?
    end

    # Attendee features
    weights = @features.sum { |feature, weight| eval(feature.to_s).new(@slot, @attendee).enabled? ? weight : 0 }
    maximum_weights = @features.sum { |_, weight| weight}
    1 - (weights.to_f / maximum_weights)
  end
end