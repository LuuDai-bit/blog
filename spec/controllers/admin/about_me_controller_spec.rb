require 'rails_helper'

RSpec.describe Admin::AboutMeController, type: :controller do
  let(:user) { create :user }

  before { sign_in(user) }

  describe 'GET #detail' do
    subject { get :detail }

    context 'when has 0 about me record in database' do
      it 'should assigns about me' do
        subject

        expect(assigns(:about_me)).not_to eq nil
        expect(response).to render_template(:detail)
      end
    end

    context 'when has 1 about me record in database' do
      let!(:about_me) { create(:about_me) }

      it 'should assigns about me' do
        subject

        expect(assigns(:about_me).id).to eq about_me.id
        expect(response).to render_template(:detail)
      end
    end
  end

  describe 'PATCH #update' do
    subject { patch :update, params: params }

    let(:params) { {id: user.id, about_me: about_me_params} }
    let(:about_me_params) do
      {
        content: 'Test content about me',
        content_en: 'Test content english about me'
      }
    end

    context 'when valid params' do
      it 'should render notice flash message' do
        subject

        expect(flash[:notice]).to eq 'About me updated successfully'
        expect(response).to render_template(:detail)
      end
    end

    context 'when fail' do
      before { allow_any_instance_of(AboutMe).to receive(:update).and_return(false) }
      it 'should render alert flash message' do
        subject

        expect(flash[:alert]).to eq 'About me update failed'
        expect(response).to render_template(:detail)
      end
    end
  end
end
