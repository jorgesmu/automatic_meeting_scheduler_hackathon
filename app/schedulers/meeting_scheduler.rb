class MeetingScheduler
  include MeetingsHelper
  def schedule(meeting)
    slot = find_slot(meeting)
    return nil unless slot
    schedule_meeting(meeting, slot)
    slot
  end

  private

  def find_slot(meeting)
    slot_generator = MultiStrategySlotGenerator.new(meeting)
    while candidate_slots = slot_generator.next
      candidate_slots.each do |candidate_slot|
        slot = score_slot(candidate_slot, meeting)
        return slot if slot
      end
    end
    nil
  end

  def features
    {
      # feature: feature_weight
      InterruptionFeature: 10,
      CollisionFeature: 6,
      LunchFeature: 3,
      VacationFeature: 5
    }
  end

  def score_slot(slot, meeting)
    scores = meeting.attendees.map do |attendee|
      scorer = PonderatedAverageScorer.new(slot, attendee, features)
      scorer.calculate
    end
    global_scorer = SlotScorer.new(scores)
    return slot if global_scorer.approved?
    nil
  end
end