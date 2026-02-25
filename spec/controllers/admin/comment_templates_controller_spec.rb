require 'rails_helper'

RSpec.describe Admin::CommentTemplatesController, type: :controller do
  let(:user) { create :user }

  before { sign_in(user) }

  describe 'GET #index' do
    let(:params) do
      {
        page: 5,
        per_page: 20
      }
    end
    let(:comment_templates) do
      {
        'data' => []
      }
    end

    subject { get :index, params: params }

    before do
      allow_any_instance_of(described_class).to receive(:get_comment_templates).and_return(comment_templates)
    end

    context 'when success' do
      it 'should assigns comment templates' do
        subject

        comment_templates = assigns(:comment_templates)
        expect(comment_templates).to eq []
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #new' do
    subject { get :new }

    context 'when success' do
      it 'should render new page' do
        subject

        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    let(:params) do
      {
        comment_template: {
          content: 'Test comment template',
          repository_id: 1
        }
      }
    end

    subject { post :create, params: params }

    context 'when success' do
      before do
        allow_any_instance_of(described_class).to receive(:create_comment_templates).and_return(double(code: 201))
      end

      it 'should redirect to index page' do
        subject
        expect(response).to redirect_to admin_comment_templates_path
        expect(flash[:notice]).to eq 'Comment template created'
      end
    end

    context 'when failed' do
      before do
        allow_any_instance_of(described_class).to receive(:create_comment_templates).and_return(double(code: 422))
      end

      it 'should render new template' do
        subject
        expect(response).to render_template :new
        expect(flash[:danger]).to eq "There's error while create comment template"
      end
    end
  end

  describe 'GET #edit' do
    let(:params) do
      {
        id: 1
      }
    end

    subject { get :edit, params: params }

    context 'when success' do
      let(:comment_template) do
        {
          'data' => {
            content: 'Test comment template',
            repository_id: 1
          }
        }
      end

      before do
        allow_any_instance_of(described_class).to receive(:get_comment_template).and_return(comment_template)
      end

      it 'should assigns comment template' do
        subject

        comment_template = assigns(:comment_template)
        expect(comment_template).to eq content: 'Test comment template', repository_id: 1
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    let(:params) do
      {
        id: 1,
        comment_template: {
          content: 'Updated comment template',
          repository_id: 2
        }
      }
    end

    subject { patch :update, params: params }

    before do
      allow_any_instance_of(described_class).to receive(:update_comment_template).and_return(double(code: 200))
      allow_any_instance_of(described_class).to receive(:get_comment_template).and_return(double('data' => params[:comment_template]))
    end

    context 'when success' do
      it 'should redirect to index page' do
        subject
        expect(response).to redirect_to admin_comment_templates_path
        expect(flash[:notice]).to eq 'Comment template updated'
      end
    end

    context 'when failed' do
      before do
        allow_any_instance_of(described_class).to receive(:update_comment_template).and_return(double(code: 422))
        response = { data: { content: 'Test comment template', repository_id: 1 } }
        allow_any_instance_of(described_class).to receive(:get_comment_template).and_return(response)
      end

      it 'should render edit template' do
        subject
        expect(response).to render_template :edit
        expect(flash[:danger]).to eq "There's error while update comment template"
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:params) do
      {
        id: 1
      }
    end

    subject { delete :destroy, params: params }

    context 'when success' do
      before do
        allow_any_instance_of(described_class).to receive(:destroy_comment_template).and_return(double(code: 200))
      end

      it 'should redirect to index page' do
        subject
        expect(response).to redirect_to admin_comment_templates_path
        expect(flash[:notice]).to eq 'Comment template deleted'
      end
    end

    context 'when failed' do
      before do
        allow_any_instance_of(described_class).to receive(:destroy_comment_template).and_return(double(code: 422))
      end

      it 'should redirect to index page with error message' do
        subject
        expect(response).to redirect_to admin_comment_templates_path
        expect(flash[:danger]).to eq "There's error while delete comment template"
      end
    end
  end
end
