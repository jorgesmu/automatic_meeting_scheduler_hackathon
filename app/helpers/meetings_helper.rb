module MeetingsHelper
  include TimingHelper

  def get_events(attendee, opts = {})
    GoogleCalendarAdapter.new.get_meetings(attendee, opts)
  end

  def meetings_in_interval?(attendee, no_interruption_inteval)
    meetings = get_events(attendee, max_results: 1, time_min: no_interruption_inteval[:start_time].iso8601)
    return false if meetings.items.size.zero?
    # Google api returns the first event after time min so we need to make sure its in the interval
    interruption_candidate_meeting = meetings.items.first
    interruption_interruption_interval = {
        start_time: (interruption_candidate_meeting.start.date_time || interruption_candidate_meeting.start.date),
        end_time: (interruption_candidate_meeting.end.date_time || interruption_candidate_meeting.end.date)
    }
    time_collision(interruption_interruption_interval, no_interruption_inteval)
  end

  def schedule_meeting(meeting, slot)
    GoogleCalendarAdapter.new.create_meeting(meeting, slot)
  end
end
