# frozen_string_literal: true

FactoryBot.define do
  factory :user_reminder do
    user
    reminder
  end
end
