class RetryEvent < ApplicationRecord
  validates :event_id, presence: true
  validates :retry_count, numericality: { only_integer: true, greater_than: 0,
    less_than: Settings.models.retry_event.max_retry }
end
