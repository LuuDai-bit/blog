# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Statistic::CalculateServerCostService, type: :service do
  subject { described_class.run }

  context 'when have both aws cost and digital ocean cost' do
    before do
      http = double('http')
      allow(Net::HTTP).to receive(:new).and_return(http)
      allow(Net::HTTP::Get).to receive(:new).and_return(http)
      allow(http).to receive(:request).and_return true
      allow(http).to receive(:use_ssl=).and_return true
      response = double({body: { 'month_to_date_balance' => '19.1'}.to_json})
      allow(http).to receive(:request).and_return(response)
    end

    it 'should return sum of 2 cost' do
      cost = described_class.run
      expect(cost).to eq 19.1
    end
  end
end
