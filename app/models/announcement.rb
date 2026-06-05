class Announcement < ApplicationRecord
  belongs_to :user

  validates :content, :color_config, presence: true

  scope :active, ->() { where(activated: true) }
  scope :display, ->() { active.where('end_at > ? or end_at IS NULL', Time.current) }

  def css_class
    "dialog-#{Dialog.new.css_class(type: self.color_config)}"
  end
end
