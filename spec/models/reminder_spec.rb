# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reminder, type: :model do
  let(:reminder) { FactoryBot.build(:reminder) }

  describe 'associations' do
    it { should have_many(:user_reminders) }
    it { should have_many(:users).through(:user_reminders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:day) }
    it { should validate_inclusion_of(:only_once).in_array([true, false]) }
    it { should validate_length_of(:content).is_at_most(255) }
  end
end
