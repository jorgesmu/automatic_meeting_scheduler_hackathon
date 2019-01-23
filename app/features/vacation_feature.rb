class VacationFeature < SpecificEventFeature
  include MeetingsHelper
  protected

  def calculate
    return true if super == true
    # TODO: check if the the looked_event is in the same day
    false
  end

  def time_min
    start_date_copy = @slot[:start_time].clone
    start_date_copy.change(hour: 0, min: 0)
    start_date_copy.iso8601
  end

  def event_name
    'vacation'
  end

end