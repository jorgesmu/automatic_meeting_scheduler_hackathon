module AttendeesHelper
  def busy_intervals(attendees, timezone, interval)
    attendees_emails = attendees.map &:email
    GoogleCalendarAdapter.new.get_free_busy(attendees_emails, timezone, time_min: interval[:start_time], time_max: interval[:end_time])
  end
end
