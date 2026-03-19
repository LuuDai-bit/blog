# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Statistic::AnnuallyPostProgressService, type: :service do
  subject { described_class.run }

  context 'when has data' do
    let!(:post) { create(:post, created_at: Time.current, release_date: Time.current, status: :publish) }

    it 'should return statistic number' do
      annually_posts_progress = subject

      expect(annually_posts_progress).to eq 8.33
    end
  end

  context 'when exceed kpi, well done' do
    let!(:post) do
      create_list(:post,
                  Settings.target.annually_posts_count + 1,
                  created_at: Time.current,
                  release_date: Time.current,
                  status: :publish)
    end

    it 'should return statistic number' do
      annually_posts_progress = subject

      expect(annually_posts_progress).to eq 100
    end
  end
end
