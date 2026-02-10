# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }

  describe 'associations' do
    it { should have_many(:user_reminders) }
    it { should have_many(:reminders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
  end
end
