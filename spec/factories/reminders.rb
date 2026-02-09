# frozen_string_literal: true

FactoryBot.define do
  factory :reminder do
    title { FFaker::Book.title }
    content { FFaker::Lorem.paragraph }
    only_once { true }
    day { ['weekday'] }
  end
end
