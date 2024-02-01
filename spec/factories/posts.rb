# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    subject { FFaker::Book.title }
    content { FFaker::Lorem.paragraph }
    status { 'draft' }
    views { 0 }

    user
  end
end
