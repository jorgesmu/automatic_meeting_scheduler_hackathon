module MeetingsHelper
  include TimingHelper
  def meetings_in_interval?(no_interruption_inteval)
    meetings = GoogleCalendarAdapter.new.get_meetings(max_results: 1, time_min: no_interruption_inteval[:start_time].iso8601)
    return false if meetings.items.size.zero?
    # Google api returns the first event after time min so we need to make sure its in the interval
    interruption_candidate_meeting = meetings.first
    return true if time_in_interval(interruption_candidate_meeting.dig('start', 'dateTime'), no_interruption_inteval)
    false
  end

end
