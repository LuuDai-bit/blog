require 'rails_helper'

RSpec.describe Admin::VariablesController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { name: 'test', format: 'text', repository_id: 1 } }
  let(:invalid_attributes) { { name: '', format: 'text', repository_id: 1 } }
  let(:valid_session) { {} }

  before { sign_in user }

  describe "GET #index" do
    before do
      response = double(code:200, 'data': [])
      allow(response).to receive(:[]).with('data').and_return([])
      allow_any_instance_of(described_class).to receive(:get_variables).and_return(response)
    end

    it "returns a success response" do
      get :index, params: { repository_id: 1 }, session: valid_session
      expect(response).to be_successful
    end

    context 'when response return error' do
      before do
        response = double(code: 422, 'data': [])
        allow(response).to receive(:[]).with('data').and_return([])
        allow_any_instance_of(described_class).to receive(:get_variables).and_return(response)
      end

      it 'should return an error response' do
        get :index, params: { repository_id: 1 }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).not_to eq(nil)
      end
    end
  end

  describe "POST #create" do
    before do
      response = double(code:200, 'data': [])
      data = double(variables: [])
      allow(response).to receive(:[]).with('data').and_return(data)
      allow(data).to receive(:[]).with('variables').and_return([])
      allow_any_instance_of(described_class).to receive(:create_variable).and_return(double(code: 201, data: {}))
      allow_any_instance_of(described_class).to receive(:get_repository).and_return(response)
    end

    context "with valid params" do
      it "returns a success response" do
        post :create, params: { variable: valid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      before do
        allow_any_instance_of(described_class).to receive(:create_variable).and_return(double(code: 422, data: {}))
      end

      it "returns an error response" do
        post :create, params: { variable: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    before do
      response = double(code:200, 'data': [])
      data = double(variables: [])
      allow(response).to receive(:[]).with('data').and_return(data)
      allow(data).to receive(:[]).with('variables').and_return([])
      allow_any_instance_of(described_class).to receive(:update_variable).and_return(double(code: 200, data: {}))
      allow_any_instance_of(described_class).to receive(:get_repository).and_return(response)
    end

    context "with valid params" do
      let(:new_attributes) { { name: 'updated', format: 'number' } }

      it "updates the requested variable" do
        put :update, params: { id: 1, variable: new_attributes }, session: valid_session
        expect(response).to be_successful
      end

      it "returns a success response" do
        put :update, params: { id: 1, variable: new_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      before do
        allow_any_instance_of(described_class).to receive(:update_variable).and_return(double(code: 422, data: {}))
      end

      it "returns an error response" do
        put :update, params: { id: 1, variable: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      response = double(code:200, 'data': [])
      data = double(variables: [])
      allow(response).to receive(:[]).with('data').and_return(data)
      allow(data).to receive(:[]).with('variables').and_return([])
      allow_any_instance_of(described_class).to receive(:destroy_variable).and_return(double(code: 200, data: {}))
      allow_any_instance_of(described_class).to receive(:get_repository).and_return(response)
    end

    it "returns a success response" do
      delete :destroy, params: { id: 1 }, session: valid_session
      expect(response).to be_successful
    end

    context 'when response return error' do
      before do
        response = double(code: 422, 'data': [])
        allow(response).to receive(:[]).with('data').and_return([])
        allow_any_instance_of(described_class).to receive(:destroy_variable).and_return(response)
      end

      it 'should return an error response' do
        delete :destroy, params: { id: 1 }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
