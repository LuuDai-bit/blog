require 'rails_helper'

RSpec.describe Admin::RepositoriesController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'POST #create' do
    subject { post :create, params: params }

    let(:params) { {repository: repository_params} }
    let(:repository_params) { {owner: 'Owner', name: 'Name'} }

    before do
      data = double(code: 201)
      allow_any_instance_of(described_class).to receive(:create_respository).and_return data
    end

    context 'when valid params' do
      it 'should return 200 success response' do
        subject

        expect(response.code).to eq '200'
        json_response = JSON.parse(response.body)
        expect(json_response['data']).not_to eq nil
      end
    end

    context 'when fail' do
      before do
        data = double(code: 422)
      allow_any_instance_of(described_class).to receive(:create_respository).and_return data
      end

      it 'should return unprocessable entity' do
        subject

        expect(response.code).to eq '422'
      end
    end
  end
end
