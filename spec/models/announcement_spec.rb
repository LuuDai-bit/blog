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

  describe 'instance methods' do
    describe 'css_class' do
      context 'when type is default' do
        it 'should return css class based on type' do
          announcement.color_config = :default
          css_class = announcement.css_class
          expect(css_class).to eq('dialog-default')
        end
      end

      context 'when type is rainbow' do
        it 'should return rainbow css class' do
          announcement.color_config = :rainbow
          css_class = announcement.css_class
          expect(css_class).to eq('dialog-rainbow')
        end
      end
    end
  end
end
