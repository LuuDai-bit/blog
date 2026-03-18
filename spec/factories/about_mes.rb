# frozen_string_literal: true

FactoryBot.define do
  factory :about_me do
    content { FFaker::Book.title }
    content_en { FFaker::Book.title }
  end
end
