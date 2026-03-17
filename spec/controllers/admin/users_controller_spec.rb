require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:user) { create :user }

  before { sign_in(user) }

  describe 'GET #show' do
    subject { get :show, params: { id: user.id } }

    it 'should assigns user' do
      subject

      expect(assigns(:user).id).to eq user.id
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it 'should assigns new user' do
      subject

      expect(assigns(:user).id).to eq nil
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: user.id } }

    it 'should assigns user' do
      subject

      expect(assigns(:user).id).to eq user.id
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    subject { patch :update, params: params }
    let(:user_params) do
      {
        name: 'Test',
        email: 'test@example.com',
        password: 'Test@password123',
        password_confirmation: 'Test@password123'
      }
    end
    let(:params) { {id: user.id, user: user_params} }

    context 'when success' do
      it 'should update current user information' do
        subject

        expect(user.reload.name).to eq 'Test'
      end
    end

    context 'when fail' do
      context 'when required field is blank' do
        it 'should return blank error' do
          user_params[:name] = nil
          subject

          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }
    let(:user_params) do
      {
        name: 'Test',
        email: 'test@example.com',
        phone_number: '+84349876543',
        password: 'Test@password123',
        password_confirmation: 'Test@password123'
      }
    end
    let(:params) { {user: user_params} }

    context 'when success' do
      it 'should add one user record to database' do
        expect { subject }.to change { User.count }.by(1)
      end

      it 'should return success message' do
        subject

        expect(flash[:notice]).to eq 'User created'
        expect(response).to redirect_to root_path
      end
    end

    context 'when fail' do
      context 'when missing required params' do
        it 'should return error message' do
          user_params[:phone_number] = nil
          subject

          expect(flash[:alert]).to eq 'User create failed'
          expect(response).to render_template :new
        end
      end
    end
  end
end
