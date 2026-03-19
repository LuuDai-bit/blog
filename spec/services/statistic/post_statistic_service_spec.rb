# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Statistic::PostStatisticService, type: :service do
  subject { described_class.run(target_day, statistic_type) }
  let(:target_day) { Time.current }
  let!(:post_in_week) do
    create(:post,
           created_at: Time.current.beginning_of_week,
           release_date: Time.current.beginning_of_week,
           status: :publish)
  end
  let!(:post_in_month) do
    create(:post,
           created_at: Time.current.beginning_of_month,
           release_date: Time.current.beginning_of_month,
           status: :publish)
  end
  let!(:today_post) do
    create(:post,
           created_at: Time.current,
           release_date: Time.current,
           status: :publish)
  end

  before do
    Timecop.freeze(Time.zone.local(2026, 3, 19, 10, 0, 0))
  end

  after do
    Timecop.return
  end

  context 'when statistic type is post per week' do
    let(:statistic_type) { Settings.models.post.statistic.post_per_week }

    it 'should return 2 posts count' do
      post_count = subject

      expect(post_count).to eq 2
    end
  end

  context 'when statistic type is post per month' do
    let(:statistic_type) { Settings.models.post.statistic.post_per_month }

    it 'should return 3 posts count' do
      post_count = subject

      expect(post_count).to eq 3
    end
  end

  context 'when statistic type is day' do
    let(:statistic_type) { 'day' }

    it 'should return 1 post count' do
      post_count = subject

      expect(post_count).to eq 1
    end
  end
end
