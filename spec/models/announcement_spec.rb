# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Announcement, type: :model do
  let(:announcement) { FactoryBot.build(:announcement) }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:color_config) }
    it { should validate_inclusion_of(:color_config).in_array(Dialog.allowed_options) }
  end
end
