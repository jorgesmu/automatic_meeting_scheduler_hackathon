module TimingHelper
  def before(t1,t2)
    t1 <= t2
  end

  def after(t1,t2)
    t1 >= t2
  end

  def time_collision(interval1, interval2)
    time_in_interval(interval2[:start_time], interval1) ||
    time_in_interval(interval2[:end_time], interval1) ||
    time_in_interval(interval1[:start_time], interval2) ||
    time_in_interval(interval1[:end_time], interval2)
  end

  def time_in_interval(time, interval)
    return true if after(time, interval[:start_time]) && before(time, interval[:end_time])
    false
  end

end
