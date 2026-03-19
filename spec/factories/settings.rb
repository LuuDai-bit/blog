# frozen_string_literal: true

FactoryBot.define do
  factory :setting do
    name { FFaker::Book.title }
  end
end
