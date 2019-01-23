class BaseFeature
  def enabled?
    @feature_enabled
  end

  def disabled?
    !enabled?
  end
end