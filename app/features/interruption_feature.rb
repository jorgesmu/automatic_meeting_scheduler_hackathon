class InterruptionFeature < BaseFeature

  def enabled?
    @feature_enabled ||= calculate
  end

  def disabled?
    !enabled?
  end

  protected

  def calculate
    @feature_enabled ||= is_an_interruption?
  end

  private

  def is_an_interruption?
    meeting_free_time = @slot[:start_time] - 1.hour
    meetings = GoogleCalendarAdapter.new.get_meetings(max_results: 1, time_min: meeting_free_time.iso8601)
    o
    meetings.items.size.positive?
  end
end