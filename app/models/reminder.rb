class Reminder < ApplicationRecord
  has_many :user_reminders, dependent: :destroy
  has_many :users, through: :user_reminders

  validates :content, :day, :hour, :minute, presence: true
  validates :only_once, inclusion: [true, false]
  validates :content, length: { minimun: 1, maximum: 60 }
end
