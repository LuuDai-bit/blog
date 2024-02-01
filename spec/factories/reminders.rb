# frozen_string_literal: true

FactoryBot.define do
  factory :remindner do
    title { FFaker::Book.title }
    content { FFaker::Lorem.paragraph }
  end
end
