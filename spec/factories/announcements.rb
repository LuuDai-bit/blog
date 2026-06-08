# frozen_string_literal: true

FactoryBot.define do
  factory :announcement do
    content { FFaker::Book.title }
    start_at { Time.current }
    duration { 1000 }
    end_at { start_at.since(duration) }
    color_config { Dialog.allowed_options.sample.to_s }

    user
  end
end
