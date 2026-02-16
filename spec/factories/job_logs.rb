# frozen_string_literal: true

FactoryBot.define do
  factory :job_log do
    job_name { FFaker::Book.title }
  end
end
