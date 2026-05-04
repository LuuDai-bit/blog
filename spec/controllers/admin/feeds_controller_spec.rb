require 'rails_helper'

RSpec.describe Admin::FeedsController, type: :controller do
  let(:user) { create :user }

  before { sign_in(user) }

  describe 'GET #index' do
    subject { get :index, params: params }

    let(:params) { {page: page, per: per_page} }
    let(:page) { 1 }
    let(:per_page) { 10 }
    let(:mock_response) do
      [
        {
          id: 1,
          title: 'Test feed 1',
          description: 'Description'
        },
        {
          id: 2,
          title: 'Test feed 2',
          description: 'Description'
        }
      ]
    end

    before do
      allow(::Feed).to receive(:list_with_pagination).and_return :mock_response
    end

    context 'when page nil' do
      let(:page) { nil }

      it 'should use the default page = 1 and return response' do
        subject

        expect(assigns(:page)).to eq 1
        expect(response).to render_template :index
      end
    end

    context 'when per_page nil' do
      let(:per_page) { nil }

      it 'should use the default per_page = 20 and return response' do
        subject

        expect(assigns(:per_page)).to eq 20
        expect(response).to render_template :index
      end
    end

    context 'when page and per_page is not nil' do
      it 'should render template index' do
        subject

        expect(assigns(:page)).to eq 1
        expect(assigns(:per_page)).to eq 10
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #mark_as_read' do
    subject { get :index, params: params }

    let(:params) { {id: 123} }

    before do
      allow(HTTParty).to receive(:get).and_return(response)
    end

    context 'when success' do
      let(:response) do
        instance_double(
          HTTParty::Response,
          code: 200,
          body: { success: true }.to_json,
          parsed_response: { "success": true }
        )
      end

      it 'should return success message' do
        subject

        expect(response.code).to eq 200
      end
    end

    context 'when fail' do
      let(:response) do
        instance_double(
          HTTParty::Response,
          code: 400,
          body: { success: false }.to_json,
          parsed_response: { "success": false }
        )
      end

      it 'should return fail status' do
        subject

        expect(response.code).to eq 400
      end
    end
  end
end
