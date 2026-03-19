# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Statistic::LogStatisticService, type: :service do
  subject { described_class.run }

  let!(:log) { create(:log, access_count: 5, ip_address: 'Ip1') }
  let!(:other_log) { create(:log, access_count: 1, ip_address: 'Ip2') }

  context 'when success' do
    it 'should return access object contains log statistic for this month' do
      access_object = subject

      expect(access_object[:total_access_in_month]).to eq 2
      expect(access_object[:total_request_in_month]).to eq 6
      expect(access_object[:highest_request_in_month]).to eq 5
    end
  end
end
