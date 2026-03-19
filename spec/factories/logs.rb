# frozen_string_literal: true

FactoryBot.define do
  factory :log do
    access_count { (0..10).to_a.sample }
    ip_address { 'test' }
  end
end
