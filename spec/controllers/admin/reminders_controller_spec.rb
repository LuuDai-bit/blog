require 'rails_helper'

RSpec.describe Admin::RemindersController, type: :controller do
  let(:user) { create(:user) }
  let(:reminder) { create(:reminder) }

  before { sign_in user }

  describe 'GET #index' do
    context 'when there are reminders' do
      it 'returns success' do
        reminder = create(:reminder)
        get :index
        expect(response).to be_successful
        expect(assigns(:reminders)).to eq([reminder])
      end
    end

    context 'when there are no reminders' do
      it 'should return empty reminders' do
        get :index
        expect(assigns(:reminders)).to be_empty
      end
    end
  end

  describe 'GET #new' do
    it 'returns success' do
      get :new
      expect(response).to be_successful
      expect(assigns(:reminder).target_date).to eq Time.current.beginning_of_day
    end
  end

  describe 'POST #create' do
    let(:params) do
      {
        reminder: {
          title: 'Test',
          content: 'Content',
          hour: '10',
          minute: '30',
          original_timezone: '-1',
          day: ['monday', 'wednesday']
        }
      }
    end

    subject { post :create, params: params }

    before { subject }

    context 'success' do
      context 'when reminder created successfully' do
        it 'should create one reminder record' do
          expect(Reminder.count).to eq 1
          reminder = Reminder.last
          expect(reminder.title).to eq 'Test'
          expect(reminder.day).to eq ['Mon', 'Wed']
        end

        it 'should redirect to admin reminders page' do
          expect(response).to redirect_to(admin_reminders_path)
        end
      end
    end

    context 'fail' do
      context 'when missing required field' do
        let(:params) do
          {
            reminder: {
              title: 'Test',
              content: nil,
              hour: '10',
              minute: '30',
              original_timezone: '-1',
              day: ['monday']
            }
          }
        end

        it 'should return errors' do
          reminder = assigns(:reminder)
          expect(reminder.errors.messages[:content]).to eq ["can't be blank"]
        end

        it 'should render new template' do
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns reminder' do
      get :edit, params: { id: reminder.id }
      expect(assigns(:reminder)).to eq(reminder)
    end
  end

  describe 'PATCH #update' do
    let(:reminder) { create :reminder }
    let(:params) do
      {
        id: reminder.id,
        reminder: {
          title: 'Updated',
          day: ['Mon', 'Tue']
        }
      }
    end

    subject { patch :update, params: params }

    before do |example|
      unless example.metadata[:skip_before]
        subject
      end
    end

    context 'success' do
      it 'should update reminder title' do
        expect(reminder.reload.title).to eq 'Updated'
      end

      it 'should redirect to admin reminder path' do
        expect(response).to redirect_to(admin_reminders_path)
      end
    end

    context 'fail' do
      context 'when update required field to nil' do
        let(:params) do
          {
            id: reminder.id,
            reminder: {
              content: nil,
              day: ['Mon']
            }
          }
        end

        it 'should return not nil errors' do
          updating_reminder = assigns(:reminder)
          expect(updating_reminder.errors.messages[:content]).to eq ["can't be blank"]
        end

        it 'should render edit template' do
          expect(response).to render_template(:edit)
        end
      end

      context 'when reminder not found' do
        let(:params) do
          {
            id: 0,
            reminder: {
              content: 'Test reminder updated',
              day: ['Mon']
            }
          }
        end

        it 'should return not found error', skip_before: true do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:reminder) { create :reminder }

    let(:params) { { id: reminder.id } }
    subject { delete :destroy, params: params }

    it 'destroys reminder' do
      expect { subject }.to change(Reminder, :count).by(-1)
    end

    it 'redirects after destroy' do
      subject
      expect(response).to redirect_to(admin_reminders_path)
    end
  end
end
