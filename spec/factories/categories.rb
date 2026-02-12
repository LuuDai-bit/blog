# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { FFaker::Book.title }
  end
end
