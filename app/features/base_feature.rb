class BaseFeature
  def initialize(slot, attendee)
    @slot = slot
    @attendee = attendee
  end

  def enabled?
    @feature_enabled ||= calculate
  end

  def disabled?
    !enabled?
  end

  protected

  def calculate
    raise('Not implemented yet')
  end
end