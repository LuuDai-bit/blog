class Remind < ApplicationRecord
  validates :content, :day, :hour, :minute, presence: true
  validates :only_once, inclusion: [true, false]
end
