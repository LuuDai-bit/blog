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

    context 'when there is no theme setting in database' do
      let!(:setting) { create(:setting, name: 'test', value: 'value') }

      it 'should assigns theme setting' do
        subject

        expect(assigns(:theme)).to eq 'default'
        expect(response).to render_template(:edit)
      end
    end

    context 'when there is theme setting in database' do
      let!(:setting) { create(:setting, name: 'theme', value: 'theme1') }

      it 'should assigns theme setting' do
        subject

        expect(assigns(:theme)).to eq 'theme1'
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
      context 'when setting is blank' do
        it 'should add 1 setting record to database' do
          expect { subject }.to change { Setting.count }.by(1)
        end
      end

      context 'when setting is present' do
        let!(:setting) { create(:setting, name: 'theme', value: 'test') }

        it 'should update current setting' do
          subject

          expect(setting.reload.value).to eq 'theme 1'
        end
      end

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
