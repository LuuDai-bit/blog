require 'rails_helper'

RSpec.describe Admin::AnnouncementsController, type: :controller do
  let(:user) { create :user }

  before { sign_in(user) }

  describe 'GET #index' do
    subject { get :index }

    before { subject }

    context 'when there is 0 announcement' do
      it 'should return empty array' do
        announcements = assigns(:announcements)
        expect(announcements).to be_empty
      end
    end

    context 'when there is 1 announcement' do
      let!(:announcement) { create :announcement, user: user }

      it 'should return array with 1 element' do
        announcements = assigns(:announcements)
        expect(announcements.pluck(:id)).to eq [announcement.id]
      end
    end

    it 'should render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    subject { get :new }

    before { subject }

    it 'should render new template' do
      expect(response).to render_template(:new)
    end

    it 'should create empty announcement' do
      announcement = assigns(:announcement)
      expect(announcement).not_to eq nil
      expect(announcement.id).to eq nil
    end
  end

  describe 'POST #create' do
    let(:params) do
      {
        announcement: {
          content: 'Test announcement',
          activated: true,
          duration: 1000
        }
      }
    end

    subject { post :create, params: params }

    before do
      Timecop.freeze(Time.zone.local(2026, 2, 9, 10, 0, 0)) # Monday
      subject
    end

    after { Timecop.return }

    context 'success' do
      context 'when create valid announcement' do
        it 'should create 1 announcement' do
          announcement = assigns(:announcement)
          expect(announcement.content).to eq 'Test announcement'
          expect(announcement.start_at).to eq Time.current
          expect(announcement.end_at).to eq Time.current.since(1000)
        end

        it 'should redirect to admin announcement list' do
          expect(flash[:notice]).to eq 'Announcement created'
          expect(response).to redirect_to(admin_announcements_path)
        end
      end
    end

    context 'fail' do
      context 'when missing required field' do
        let(:params) do
          {
            announcement: {
              content: nil,
              activated: true,
              duration: 1000
            }
          }
        end

        it 'should return missing error' do
          announcement = assigns(:announcement)
          expect(announcement.errors.messages[:content]).to eq ["can't be blank"]
        end

        it 'should render new template' do
          expect(flash[:alert]).to eq 'Announcement create failed'
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'PATCH #update' do
    let!(:announcement) { create :announcement, user: user }

    let(:params) do
      {
        id: announcement.id,
        announcement: {
          activated: false
        }
      }
    end
    subject { patch :update, params: params}

    context 'success' do
      it 'should change activated status to false' do
        subject

        announcement = assigns(:announcement)
        expect(announcement.activated).to be_falsy
      end

      it 'should redirect to admin announcement list' do
        subject

        expect(response).to redirect_to admin_announcements_path
        expect(flash[:notice]).to eq 'Announcement updated'
      end
    end

    context 'fail' do
      context 'when update announcement content to nil' do
        let(:params) do
          {
            id: announcement.id,
            announcement: {
              content: nil
            }
          }
        end

        it 'should return not nil error' do
          subject

          announcement = assigns(:announcement)
          expect(announcement.errors.messages[:content]).to eq ["can't be blank"]
        end
      end

      context 'when update non exist announcement' do
        let(:params) do
          {
            id: 0,
            announcement: {
              content: 'Test'
            }
          }
        end

        it 'should raise not found error' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
