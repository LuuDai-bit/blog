class RetryEvent < ApplicationRecord
  validates :event_id, presence: true
  validates :retry_count, numericality: { only_integer: true, greater_than: 0,
    less_or_eq_than: Settings.models.retry_event.max_retry }

  def increase_retry_count
    update(retry_count: retry_count + 1)
  end
end
