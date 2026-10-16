# frozen_string_literal: true

FactoryBot.define do
  factory :draft_post do
    subject { FFaker::Book.title }
    subject_en { FFaker::Book.title }

    post
  end
end
