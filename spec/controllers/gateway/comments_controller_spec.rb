require 'rails_helper'

RSpec.describe Gateway::CommentsController, type: :controller do
  let(:auth_token) { create(:auth_token) }

  describe 'POST #create' do
    let(:valid_params) do
      {
        project_coverage: '85.5',
        patch_coverage: '90.2',
        pull_request_number: '123',
        owner: 'test-owner',
        repo: 'test-repo'
      }
    end

    context 'with valid authentication' do
      before do
        request.headers['Token'] = auth_token.token
      end

      context 'when HTTParty request succeeds' do
        before do
          allow_any_instance_of(CommentGrpcClient).to receive(:create_comment).and_return('success')
        end

        it 'makes a POST request to the external API' do
          post :create, params: valid_params

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:success)
          expect(json_response['message']).to eq 'Success'
        end
      end

      context 'when HTTParty request fails' do
        before do
          allow_any_instance_of(CommentGrpcClient).to receive(:create_comment).and_raise(StandardError.new('Connection failed'))
        end

        it 'returns error message with exception' do
          post :create, params: valid_params

          expect(response).to have_http_status(:internal_server_error)
          response_body = JSON.parse(response.body)
          expect(response_body['message']).to eq('Failed')
          expect(response_body['exception']).to eq('Connection failed')
        end
      end
    end

    context 'with lowercase token header' do
      before do
        request.headers['token'] = auth_token.token
      end

      it 'authenticates successfully' do
        allow_any_instance_of(CommentGrpcClient).to receive(:create_comment).and_return('success')

        post :create, params: valid_params

        expect(response).to have_http_status(:success)
      end
    end
  end
end