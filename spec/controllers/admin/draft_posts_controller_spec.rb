require 'rails_helper'

RSpec.describe Admin::DraftPostsController, type: :controller do
  let(:user) { create :user }

  before { sign_in(user) }

  describe 'GET #show' do
    subject { get :show, params: { id: id } }

    let!(:draft_post) { create(:draft_post) }
    let(:id) { draft_post.id }

    context 'when success' do
      it 'should load correct draft post' do
        subject

        draft_post_id = assigns(:draft_post).id
        expect(draft_post_id).to eq id
      end

      it 'should render show template' do
        subject

        expect(response).to render_template(:show)
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    let(:post_example) { create(:post) }
    let(:params) do
      {
        draft_post: {
          subject: 'Test Draft Post',
          subject_en: 'Test Draft Post EN',
          content: 'Test content',
          content_en: 'Test content EN',
          post_id: post_example.id
        }
      }
    end

    context 'when success' do
      it 'should add 1 draft_post record to database' do
        expect { subject }.to change(DraftPost, :count).by(1)
      end

      it 'should create draft_post record with correct subject' do
        subject
        data = JSON.parse(response.body)
        draft_post = DraftPost.find_by_id(data['draft_post_id'])
        expect(draft_post.subject).to eq 'Test Draft Post'
      end

      it 'should return success message' do
        subject

        data = JSON.parse(response.body)
        expect(data['message']).to eq 'Successfully created draft post'
      end
    end

    context 'when fail' do
      before { allow_any_instance_of(DraftPost).to receive(:save).and_return(false) }

      it 'should add 0 draft_post record to database' do
        expect { subject }.to change(DraftPost, :count).by(0)
      end

      it 'should return fail message' do
        subject

        data = JSON.parse(response.body)
        expect(data['message']).to eq 'Failed to create draft post'
      end
    end
  end

  describe 'PATCH #update' do
    subject { patch :update, params: params }
    let!(:draft_post) { create :draft_post }
    let(:params) do
      {
        id: draft_post.id,
        draft_post: {
          subject: 'Test Draft Post Updated',
          subject_en: 'Test Draft Post EN',
          content: 'Test content',
          content_en: 'Test content EN'
        }
      }
    end
    context 'when success' do
      it 'should update draft post in database' do
        subject

        draft_post.reload
        expect(draft_post.subject).to eq 'Test Draft Post Updated'
      end

      it 'should return success message' do
        subject

        data = JSON.parse(response.body)
        expect(data['message']).to eq 'Successfully updated draft post'
      end
    end

    context 'when fail' do
      before { allow_any_instance_of(DraftPost).to receive(:save).and_return(false) }

      it 'should return error message' do
        subject

        data = JSON.parse(response.body)
        expect(data['message']).to eq 'Failed to create draft post'
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params }
    let!(:draft_post) { create :draft_post }
    let(:params) { { id: draft_post.id } }

    context 'when success' do
      it 'should rendirect to edit post path' do
        subject

        expect(response).to redirect_to(edit_admin_post_path(draft_post.post_id))
      end

      it 'should remove 1 record from draft post table' do
        expect { subject }.to change(DraftPost, :count).by(-1)
      end
    end

    context 'when fail' do
      before { allow_any_instance_of(DraftPost).to receive(:destroy).and_return(false) }

      it 'should render show' do
        subject

        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #apply' do
    subject { get :apply, params: params }

    let(:post) { create :post }
    let!(:draft_post) { create :draft_post, post: post }
    let(:params) { {id: draft_post.id} }

    context 'when success' do
      it 'should redirect to edit admin post path' do
        subject

        expect(response).to redirect_to(edit_admin_post_path(draft_post.post_id))
      end

      it 'should change content of original post to draft_post' do
        subject

        post.reload
        expect(post.subject).to eq draft_post.subject
        expect(post.subject_en).to eq draft_post.subject_en
      end
    end

    context 'when fail' do
      before { allow_any_instance_of(Post).to receive(:save).and_raise(StandardError) }
      it 'should render show' do
        subject

        expect(response).to render_template(:show)
      end
    end
  end
end
