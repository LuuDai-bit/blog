require 'rails_helper'

RSpec.describe Admin::SettingsController, type: :controller do
  let(:user) { create :user }

  before { sign_in(user) }

  describe 'GET #index' do
    subject { get :index }

    context 'when success' do
      it 'should assigns theme setting' do
        subject

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit }

    context 'when success' do
      it 'should assigns theme setting' do
        subject

        expect(assigns(:theme)).not_to eq nil
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH #update' do
    subject { patch :update, params: params }
    let(:params) { {settings: setting_params} }
    let(:setting_params) do
      {
        theme: 'theme 1'
      }
    end

    context 'when success' do
      it 'should return notice flash message' do
        subject

        expect(flash[:notice]).to eq 'Settings updated successfully.'
        expect(response).to redirect_to admin_settings_path
      end
    end

    context 'when fail' do
      before { allow(Setting).to receive(:where).and_raise(StandardError) }

      it 'should return alert flash message' do
        subject

        expect(flash[:alert]).to eq 'Failed to update settings: StandardError'
      end
    end
  end
end
