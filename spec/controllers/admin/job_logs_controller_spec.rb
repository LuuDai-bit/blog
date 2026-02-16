require 'rails_helper'

RSpec.describe Admin::JobLogsController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #index' do
    let!(:job_log) { create :job_log }

    subject { get :index }

    it 'should render index template' do
      subject

      expect(response).to render_template(:index)
    end

    it 'should assigns job logs' do
      subject

      job_logs = assigns(:job_logs)
      expect(job_logs.pluck(:id)).to eq [job_log.id]
    end
  end
end
