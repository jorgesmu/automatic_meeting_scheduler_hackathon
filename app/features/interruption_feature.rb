class InterruptionFeature < BaseFeature
  include MeetingsHelper
  protected

  def calculate
    time_delta = 1.hour
    pre_no_interruption_interval = {
        start_time: (@slot[:start_time] - time_delta),
        end_time: @slot[:start_time]
    }
    return true if meetings_in_interval?(@attendee, pre_no_interruption_interval)
    post_no_interruption_interval = {
        start_time: @slot[:end_time],
        end_time: (@slot[:start_time] + time_delta)
    }
    meetings_in_interval?(@attendee, post_no_interruption_interval)
    false
  end
end