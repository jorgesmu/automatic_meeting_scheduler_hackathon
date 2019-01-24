class SlotFinder

  def initialize
    @time_zone = 'Asia/Jerusalem'
    @time_min = Time.now.iso8601
    @attendees = ['jsmulevici@twistbioscience.com', 'nbenyechiel@twistbioscience.com']
    @work_hour_start =
    @work_hour_end =
  end

  def get_available_slots(time_max, time_min = @time_min, timezone = @time_zone, attendees = @attendees)
    num_of_days = time_max - time_min
    days_to_add = 0
    attendees_free_busy = GoogleCalendarAdapter.get_free_busy(time_max, time_min, timezone, attendees)
    # while days_to_add < num_of_days
    #   do time_min + days_to_add
    #     start_time =
    #     return find_free_slot() if find_free_slot().nil?
    #   end
    # end

    # for each day
    # try to find perfect slot for every
  end
end