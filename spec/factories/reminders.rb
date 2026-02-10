# frozen_string_literal: true

FactoryBot.define do
  factory :reminder do
    title { FFaker::Book.title }
    content { FFaker::Book.title }
    only_once { true }
    day { ['Mon'] }
  end
end
