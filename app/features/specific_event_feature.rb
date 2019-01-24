class SpecificEventFeature < BaseFeature
  include MeetingsHelper
  protected

  def calculate
    meetings = get_events(@attendee, max_results: max_results, time_min: time_min)
    looked_meeting = meetings.items.find { |event| event.summary.include?(event_name) }
    return false if looked_meeting.blank?
    interval = {
        start_time: DateTime.parse(looked_meeting.start.date_time || looked_meeting.start.date) ,
        end_time: DateTime.parse(looked_meeting.end.date_time || looked_meeting.end.date) }
    time_collision(interval, @slot)
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