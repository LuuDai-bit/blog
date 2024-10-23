class Announcement < ApplicationRecord
  belongs_to :user

  scope :active, ->() { where(activated: true) }
  scope :display, ->() { active.where('end_at > ? or end_at IS NULL', Time.current) }
end
