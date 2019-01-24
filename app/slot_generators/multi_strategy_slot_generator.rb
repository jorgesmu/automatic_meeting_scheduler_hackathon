class MultiStrategySlotGenerator < SlotGeneratorBase

  PARSERS_MAPPER = {
    start: NowSlotGenerator
  }

  def initialize(meeting)
    super
  end

  def next
    if !@current_class
      @current_class = PARSERS_MAPPER[:start]
      @current_parser = eval(@current_class.to_s).new(@meeting)
    end
    page = @current_parser.next
    return page if page
    @current_class = PARSERS_MAPPER[:start]
    return nil if @current_class.nil?
    @current_parser = eval(@current_class).new(@meeting)
    @current_parser.next
  end
end