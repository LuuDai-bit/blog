class JobLog < ApplicationRecord
  validates :job_name, presence: true

  scope :by_name, ->(search_name) {
    return unless search_name.present?

    where(job_name: search_name)
  }
end
