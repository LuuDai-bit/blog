class Announcement < ApplicationRecord
  belongs_to :user

  scope :active, ->() { where(activated: true) }
end
