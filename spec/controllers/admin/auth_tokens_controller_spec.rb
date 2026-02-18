require 'rails_helper'

RSpec.describe Admin::AuthTokensController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    let!(:auth_token1) { create(:auth_token, token: 'token1') }
    let!(:auth_token2) { create(:auth_token, token: 'token2') }

    it 'assigns paginated auth tokens ordered by id desc' do
      get :index

      expect(assigns(:auth_tokens)).to eq([auth_token2, auth_token1])
      expect(response).to have_http_status(:success)
    end

    it 'masks the tokens' do
      get :index

      expect(assigns(:auth_tokens).first.token).to eq('**********')
      expect(assigns(:auth_tokens).last.token).to eq('**********')
    end
  end

  describe 'GET #show' do
    let(:auth_token) { create(:auth_token) }

    it 'assigns the requested auth_token' do
      get :show, params: { id: auth_token.id }, xhr: true

      expect(assigns(:auth_token)).to eq(auth_token)
    end

    context 'when auth_token does not exist' do
      it 'assigns nil to @auth_token' do
        get :show, params: { id: 999 }, xhr: true

        expect(assigns(:auth_token)).to be_nil
      end
    end
  end

  describe 'POST #create' do
    it 'creates a new auth token with a UUID' do
      expect {
        post :create
      }.to change(AuthToken, :count).by(1)

      auth_token = AuthToken.last
      expect(auth_token.token).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/)
    end

    it 'redirects to admin_auth_tokens_path with success flash' do
      post :create

      expect(response).to redirect_to(admin_auth_tokens_path)
      expect(flash[:notice]).to eq('Authentication token created')
    end

    context 'when save fails' do
      before do
        allow_any_instance_of(AuthToken).to receive(:save).and_return(false)
      end

      it 'renders index with alert flash' do
        post :create

        expect(response).to render_template(:index)
        expect(flash[:alert]).to eq('Error occurs while creating authentication token')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:auth_token) { create(:auth_token) }

    it 'destroys the auth token' do
      expect {
        delete :destroy, params: { id: auth_token.id }
      }.to change(AuthToken, :count).by(-1)
    end

    it 'redirects to admin_auth_tokens_path with success flash' do
      delete :destroy, params: { id: auth_token.id }

      expect(response).to redirect_to(admin_auth_tokens_path)
      expect(flash[:notice]).to eq('Authentication token deleted')
    end

    context 'when destroy fails' do
      before do
        allow_any_instance_of(AuthToken).to receive(:destroy).and_return(false)
      end

      it 'renders index with alert flash' do
        delete :destroy, params: { id: auth_token.id }

        expect(response).to render_template(:index)
        expect(flash[:alert]).to eq('Error occurs while delete authentication token')
      end
    end
  end
end
