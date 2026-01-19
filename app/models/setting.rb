class Setting < ApplicationRecord
  THEME_OPTIONS = [
    {
      name: 'default',
      image_url: 'light_blue.jpeg'
    },
    {
      name: 'yellow_pink',
      image_url: 'yellow_pink.jpg'
    }
  ].freeze

  validates :name, :value, presence: true
end
