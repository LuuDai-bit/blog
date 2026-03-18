require 'rails_helper'

RSpec.describe User::HomeController, type: :controller do
  describe 'GET #about' do
    subject { get :about }
    let!(:about_me) { create(:about_me) }

    it 'should assigns about me' do
      subject

      about_me = assigns(:about_me)
      expect(about_me).not_to eq nil
      expect(response).to render_template(:about)
    end
  end

  describe 'GET #contact' do
    subject { get :contact }

    it 'should render contact template' do
      subject

      expect(response).to render_template(:contact)
    end
  end
end
