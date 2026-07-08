# frozen_string_literal: true

FactoryBot.define do
  factory :retry_event do
    sequence(:event_id) { |n| n }
    retry_count { 1 }
  end
end
