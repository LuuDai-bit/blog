require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #index' do
    context 'when success' do
      before { allow(Statistic::CalculateServerCostService).to receive(:run).and_return(1) }

      subject { get(:index) }

      let!(:weekly_post) do
        create(:post, created_at: Time.current, status: :publish, release_date: Time.current)
      end
      let!(:monthly_post) do
        create(:post,
               created_at: Time.current.beginning_of_month,
               status: :publish,
               release_date: Time.current.beginning_of_month)
      end

      it 'should assigns statistic value' do
        subject

        post_per_week = assigns(:post_per_week)
        post_per_month = assigns(:post_per_month)
        total_views = assigns(:total_views)

        expect(post_per_week).to eq 1
        expect(post_per_month).to eq 2
        expect(total_views).to eq (weekly_post.views + monthly_post.views)
      end
    end
  end
end
