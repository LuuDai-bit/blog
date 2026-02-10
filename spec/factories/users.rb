# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.last_name }
    phone_number { FFaker::PhoneNumber.phone_number }
    password { 'Aa@123456' }
  end
end
