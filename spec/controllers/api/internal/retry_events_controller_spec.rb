require 'rails_helper'

RSpec.describe Api::Internal::RetryEventsController, type: :controller do
  let(:auth_token) { create(:auth_token) }

  describe 'POST #create' do
    subject { post :create, params: params }

    before do
      request.headers['Token'] = auth_token.token
    end

    context 'when success' do
      let(:event_id) { '1234test56' }
      let!(:job_log) { create(:job_log, job_name: 'test', event_id: event_id) }
      let(:params) do
        {
          event_id: event_id,
          original_params: {test: 'test'}.to_json
        }
      end

      it 'should return success message with event_id' do
        subject

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(json_response['message']).to eq 'Success'
        expect(json_response['event_id']).to eq event_id
      end
    end

    context 'when failed' do
      context 'when event id not found' do
        let(:event_id) { '1234test56' }
        let(:params) do
          {
            event_id: event_id,
            original_params: {test: 'test'}.to_json
          }
        end

        it 'should return not found message' do
          subject

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:not_found)
          expect(json_response['message']).to eq 'Record not found'
        end
      end

      context 'when reach max retry limit' do
        let(:event_id) { '1234test56' }
        let!(:job_log) { create(:job_log, job_name: 'test', event_id: event_id) }
        let!(:retry_event) { create(:retry_event, retry_count: 20, event_id: event_id) }
        let(:params) do
          {
            event_id: event_id,
            original_params: {test: 'test'}.to_json
          }
        end

        it 'should return exceed max limit retry message' do
          subject

          expect(response).to have_http_status(:unprocessable_entity)
          json_response = JSON.parse(response.body)
          expect(json_response['message']).to eq 'Max retry limit reached'
        end
      end
    end
  end
end
