class Reminder < ApplicationRecord
  has_many :user_reminders

  validates :content, :day, :hour, :minute, presence: true
  validates :only_once, inclusion: [true, false]
end
