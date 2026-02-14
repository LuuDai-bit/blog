require 'rails_helper'

RSpec.describe Admin::JobLogsController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #index' do
    subject { get :index }

    it 'should render index template' do
      subject

      expect(response).to render_template(:index)
    end
  end
end
