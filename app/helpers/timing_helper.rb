module TimingHelper
  def before(t1,t2)
    t1 < t2
  end

  def after(t1,t2)
    t1 > t2
  end

  def time_collission(interval1, interval2)
    return true if after(interval1[:start_time], interval2[:end_time]) && before(interval1[:start_time], interval2[:end_time])
    return true if after(interval1[:start_time], interval2[:start_time]) && before(interval1[:start_time], interval2[:start_time])
    false
  end
end
