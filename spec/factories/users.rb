# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.last_name }
    password { 'Aa@123456' }
  end
end
