# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  let(:auth_token) { build(:auth_token) }

  describe 'validation' do
    it { should validate_presence_of(:token) }
  end

  describe 'instance method' do
    let(:auth_token) { create(:auth_token) }

    context '.mask' do
      it 'should mask the token attribute' do
        auth_token.mask

        expect(auth_token.token).to eq '**********'
      end
    end
  end
end
