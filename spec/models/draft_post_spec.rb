require 'rails_helper'

RSpec.describe DraftPost, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
  end
end
