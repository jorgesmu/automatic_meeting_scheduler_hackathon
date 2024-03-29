class LunchFeature < SpecificEventFeature
  include MeetingsHelper
  protected

  def time_min
    start_date_copy = @slot[:start_time].clone
    start_date_copy.change(hour: 11, min: 0)
    start_date_copy.iso8601
  end

  def event_name
    'lunch'
  end

end