class MeetingScheduler
  include MeetingsHelper
  def schedule(meeting)
    slots = [DateTime.now, (DateTime.now + 1.hour)]
    slot = find_slot(slots, meeting)
    return nil unless slot
    schedule_meeting(meeting, slot)
    return slot
  end

  private

  def features
    {
      # feature: feature_weight
      InterruptionFeature: 10,
      CollisionFeature: 6,
      LunchFeature: 3,
      VacationFeature: 5
    }
  end

  def find_slot(slots, meeting)
    slots.each do |slot|
      scores = meeting.attendees.map do |attendee|
        scorer = PonderatedAverageScorer.new(slot, attendee, features)
        scorer.calculate
      end
      global_scorer = SlotScorer.new(scores)
      return slot if global_scorer.approved?
    end
  end
  nil
end