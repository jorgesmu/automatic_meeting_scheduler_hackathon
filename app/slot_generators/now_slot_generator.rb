class NowSlotGenerator < SlotGeneratorBase
  def initialize(meeting)
    @yielded = false
    super
  end

  def next
    return nil if @yielded
    @yielded = true
    [{ start_time: DateTime.now, end_time: (DateTime.now + 1.hour) }]
  end
end