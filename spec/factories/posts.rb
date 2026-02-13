# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    initialize_with { type.present? ? type.constantize.new : Post.new }

    subject { FFaker::Book.title }
    content { FFaker::Lorem.paragraph }
    status { 'draft' }
    views { 0 }

    author { create(:user) }
  end
end
