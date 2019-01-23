class SpecificEventFeature < BaseFeature
  include MeetingsHelper
  protected

  def calculate
    meetings = get_events(max_results: max_results, time_min: time_min)
    looked_meeting = meetings.find { |event| event[:summary].include?(event_name) }
    return false if looked_meeting.blank?
    return true if time_in_interval(looked_meeting.dig('start', 'dateTime'), @slot)
    return true if time_in_interval(looked_meeting.dig('end', 'dateTime'), @slot)
    false
  end

  def time_min
    raise('Not implemented yet')
  end

  def max_results
    20
  end

  def event_name
    raise('Not implemented yet')
  end

end