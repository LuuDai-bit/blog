class Setting < ApplicationRecord
  THEME_OPTIONS = [
    {
      name: 'default',
      image_url: 'light-blue-theme.png'
    },
    {
      name: 'yellow_pink',
      image_url: 'yellow-pink-theme.png'
    }
  ].freeze

  validates :name, :value, presence: true
end
