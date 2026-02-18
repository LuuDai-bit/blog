# frozen_string_literal: true

FactoryBot.define do
  factory :auth_token do
    token { 'test token' }
  end
end