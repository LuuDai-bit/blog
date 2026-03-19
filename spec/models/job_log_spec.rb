# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobLog, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:job_name) }
  end

  describe 'scopes' do
    context 'by_name' do
      let!(:job) { create(:job_log, job_name: 'Test search') }
      let!(:job_other_name) { create(:job_log, job_name: 'Random') }

      it 'should return job that has matched job_name' do
        job_logs = described_class.by_name('Test search')
        expect(job_logs.pluck(:id)).to eq [job.id]
      end
    end
  end
end
