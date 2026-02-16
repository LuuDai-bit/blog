require 'rails_helper'

RSpec.describe Admin::TestController, type: :controller do
  describe 'GET #index' do
    let!(:user) { create(:user) }

    subject { get :index }

    before { sign_in(user) }

    context 'when success' do
      it 'should return users' do
        subject

        users = assigns(:users)

        expect(users.pluck(:id)).to eq [user.id]
      end
    end
  end
end
