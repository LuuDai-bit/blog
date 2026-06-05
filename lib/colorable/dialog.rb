class Dialog < Colorable
  CSS_MAPPING = {
    'default': 'default',
    'important': 'important',
    'warning': 'warning',
    'fun': 'fun',
    'info': 'info',
    'rainbow': 'rainbow'
  }.freeze

  def css_class(type:)
    CSS_MAPPING[type.to_sym]
  end

  def self.allowed_options
    CSS_MAPPING.keys
  end
end
