# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RetryEvent, type: :model do
  let(:retry_event) { FactoryBot.build(:retry_event) }

  describe 'validations' do
    it { should validate_presence_of(:event_id) }
    it { should validate_numericality_of(:retry_count).is_greater_than(0).is_less_than_or_equal_to(Settings.models.retry_event.max_retry) }
  end
end
