require 'rails_helper'

RSpec.describe Admin::PasswordsController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #edit' do
    subject { get(:edit, params: { id: user.id }) }

    it 'should render edit template' do
      subject

      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    subject { patch(:update, params: params) }

    let(:params) do
      {
        id: user.id,
        user: {
          password: 'Aa@123456',
          password_confirmation: 'Aa@123456'
        }
      }
    end

    context 'when success' do
      it 'should return success message' do
        subject

        expect(flash[:notice]).to eq 'Password updated'
        expect(response).to redirect_to admin_posts_path
      end
    end

    context 'when fail' do
      context 'when password blank' do
        let(:params) do
          {
            id: user.id,
            user: {
              password: nil,
              password_confirmation: 'Aa@123456'
            }
          }
        end

        it 'should return error message' do
          subject

          expect(flash[:alert]).to eq 'Password update failed'
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
