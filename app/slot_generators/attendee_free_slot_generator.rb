class AttendeeFreeSlotGenerator < SlotGeneratorBase
  include AttendeesHelper
  include TimingHelper

  def initialize(meeting)
    super
    @time_zone = 'Asia/Jerusalem'
    @days_from_start_time = 0
    @total_days = @meeting.ending_date.to_date - @meeting.starting_date.to_date
  end

  def next
    return nil if @days_from_start_time > @total_days

    if @days_from_start_time == 0
      start_time = DateTime.now > @meeting.starting_date ? DateTime.now : @meeting.starting_date
    else
      start_time = @meeting.starting_date + @days_from_start_time.days
      start_time.change(hour: 9, minute: 0)
    end

    end_time = start_time.clone.change(hour: 20)

    # if its the last date
    if @total_days == @days_from_start_time
      start_time = DateTime.now
      end_time = @meeting.ending_date
      return nil if start_time > end_time
    end
    @days_from_start_time += 1
    free_slots_for_attendees(start_time, end_time)
  end

  private

  def free_slots_for_attendees(start_time, end_time)
    busy_times = attendees_busy_times(start_time, end_time)
    slots = []
    duration = @meeting.duration
    current_slot_start_time = start_time.clone
    current_slot_end_time = start_time.clone + duration.minutes

    while(current_slot_end_time < end_time)
      busy_times.calendars.each do |_calendar_id, busy_intervals|
        busy_intervals = busy_intervals.busy
        # Because we have the busy agenda (and not the available) if its a match it means that there is collision and
        # we cant use this slot that why we check that sum(matches) == 0
        slot_interval = { start_time: current_slot_start_time, end_time: current_slot_end_time }
        matches = busy_intervals.map do |busy_interval|
          formatted_busy_interval = { start_time: busy_interval.start, end_time: busy_interval.end }
          time_collision(formatted_busy_interval, slot_interval) ? 1 : 0
        end
        slots.push(slot_interval) if matches.sum.zero?
        current_slot_start_time = current_slot_end_time
        current_slot_end_time = current_slot_start_time + duration.minutes
      end
    end
    slots
  end

  def attendees_busy_times(start_time, end_time)
    interval = { start_time: start_time.iso8601, end_time: end_time.iso8601 }
    busy_intervals(@meeting.attendees, @time_zone, interval)
  end
end