# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Announcement, type: :model do
  let(:announcement) { FactoryBot.build(:announcement) }

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
