class CollisionFeature < BaseFeature
  include MeetingsHelper
  private

  def calculate
    meetings_in_interval?(@attendee, @slot)
  end
end