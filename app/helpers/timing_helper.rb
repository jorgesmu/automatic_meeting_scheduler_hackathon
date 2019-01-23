module TimingHelper
  def before(t1,t2)
    t1 < t2
  end

  def after(t1,t2)
    t1 > t2
  end

  def time_collission(interval1, interval2)
    return true if time_in_interval(interval2[:start_time], interval1)
    return true if time_in_interval(interval2[:end_time], interval1)
    false
  end

  def time_in_interval(time, interval)
    return true if after(interval[:start_time], time) && before(interval[:end_time], time)
    false
  end

end
