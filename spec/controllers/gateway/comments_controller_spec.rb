require 'rails_helper'

RSpec.describe Gateway::CommentsController, type: :controller do
  let(:auth_token) { create(:auth_token) }

  describe 'POST #create' do
    let(:valid_params) do
      {
        project_coverage: '85.5',
        patch_coverage: '90.2'
      }
    end

    context 'with valid authentication' do
      before do
        request.headers['Token'] = auth_token.token
      end

      context 'when HTTParty request succeeds' do
        before do
          allow(HTTParty).to receive(:post).and_return(double(success?: true))
        end

        it 'makes a POST request to the external API' do
          expect(HTTParty).to receive(:post).with(
            'http://localhost:3000/api/v1/comments',
            body: valid_params
          )

          post :create, params: valid_params
        end

        it 'returns success message' do
          post :create, params: valid_params

          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)).to eq({ 'message' => 'Success' })
        end

        context 'with custom domain' do
          before do
            ENV['GITHUB_APP_DOMAIN'] = 'https://custom-domain.com'
          end

          after do
            ENV.delete('GITHUB_APP_DOMAIN')
          end

          it 'uses the custom domain' do
            expect(HTTParty).to receive(:post).with(
              'https://custom-domain.com/api/v1/comments',
              body: valid_params
            )

            post :create, params: valid_params
          end
        end
      end

      context 'when HTTParty request fails' do
        before do
          allow(HTTParty).to receive(:post).and_raise(StandardError.new('Connection failed'))
        end

        it 'returns error message with exception' do
          post :create, params: valid_params

          expect(response).to have_http_status(:internal_server_error)
          response_body = JSON.parse(response.body)
          expect(response_body['message']).to eq('Failed')
          expect(response_body['exception']).to eq('Connection failed')
        end
      end

      context 'with missing parameters' do
        it 'still makes the request with nil values' do
          expect(HTTParty).to receive(:post).with(
            'http://localhost:3000/api/v1/comments',
            body: { project_coverage: nil, patch_coverage: nil }
          )

          post :create
        end
      end
    end

    context 'without authentication' do
      it 'raises AuthenticationError' do
        expect {
          post :create, params: valid_params
        }.to raise_error(Gateway::ApplicationController::AuthenticationError)
      end
    end

    context 'with lowercase token header' do
      before do
        request.headers['token'] = auth_token.token
      end

      it 'authenticates successfully' do
        allow(HTTParty).to receive(:post)

        post :create, params: valid_params

        expect(response).to have_http_status(:success)
      end
    end
  end
end