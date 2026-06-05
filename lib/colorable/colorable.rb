class Colorable
  class NotImplemented < StandardError; end

  CSS_MAPPING = {}.freeze

  def css_class(type:)
    raise NotImplemented, 'No implementation'
  end

  def self.allowed_options
    raise NotImplemented, 'No implementation'
  end
end
