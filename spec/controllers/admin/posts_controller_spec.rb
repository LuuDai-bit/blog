require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do
  let(:user) { create :user }

  before { sign_in(user) }

  describe 'GET #index' do
    let(:params) { {} }

    subject { get :index, params: params }

    context 'when there are 0 post' do
      it 'should return empty array' do
        subject

        posts = assigns(:posts)
        expect(posts).to be_empty
      end

      it 'should render index template' do
        subject

        expect(response).to render_template(:index)
      end
    end

    context 'when there is 1 technical post' do
      let!(:technical_post) { create(:post) }

      it 'should return array of 1 technical post' do
        subject

        posts = assigns(:posts)
        expect(posts.pluck(:id)).to eq [technical_post.id]
      end
    end

    context 'when there are 1 technical post and 1 idle talk' do
      let!(:technical_post) { create(:post) }
      let!(:idle_talk) { create(:post, type: 'IdleTalk') }

      it 'should return array contains 2 posts' do
        subject

        posts = assigns(:posts)
        expect(posts.pluck(:id).sort).to eq [technical_post.id, idle_talk.id].sort
      end
    end

    context 'when sort by views' do
      let!(:post_10_views) { create(:post, views: 10, status: :publish, release_date: Time.current) }
      let!(:post_5_views) { create(:post, views: 5, status: :publish, release_date: Time.current) }
      let!(:post_6_views) { create(:post, views: 6, status: :publish, release_date: Time.current) }

      context 'asc' do
        let(:params) { {order_views: 'asc'} }

        it 'should return array sorted by views' do
          subject

          posts = assigns(:posts)
          expect(posts.pluck(:id)).to eq [post_5_views.id, post_6_views.id, post_10_views.id]
        end
      end

      context 'desc' do
        let(:params) { {order_views: 'desc'} }

        it 'should return array sorted by views' do
          subject

          posts = assigns(:posts)
          expect(posts.pluck(:id)).to eq [post_10_views.id, post_6_views.id, post_5_views.id]
        end
      end
    end

    context 'when have draft post and publish post' do
      let!(:publish_post) { create(:post, status: :publish, release_date: Time.current) }
      let!(:draft_post) { create(:post, status: :draft) }

      it 'should put draft post to the begin of array' do
        subject

        posts = assigns(:posts)
        expect(posts.pluck(:id)).to eq [draft_post.id, publish_post.id]
      end
    end

    context 'when filter by post type' do
      let!(:technical_post) { create(:post) }
      let!(:idle_talk) { create(:post, type: 'IdleTalk') }

      context 'by technical post' do
        let(:params) { {type: 'TechnicalPost'} }

        it 'should return technical post only' do
          subject

          posts = assigns(:posts)
          expect(posts.pluck(:id)).to eq [technical_post.id]
        end
      end

      context 'by idle talk' do
        let(:params) { {type: 'IdleTalk'} }

        it 'should return idle talk only' do
          subject

          posts = assigns(:posts)
          expect(posts.pluck(:id)).to eq [idle_talk.id]
        end
      end
    end

    context 'when search by subject' do
      let!(:post) { create(:post, subject: 'Test search') }
      let!(:post_en) { create(:post, subject: 'Some thoughts', subject_en: 'Something') }

      context 'when has result in vietnamese version' do
        let(:params) { {search_text: 'Test search'} }

        it 'should return result that has 1 post' do
          subject

          posts = assigns(:posts)
          expect(posts.pluck(:id)).to eq [post.id]
        end
      end

      context 'when has result in english version' do
        let(:params) { {search_text: 'Something'} }

        it 'should return result that has 1 post with en subject' do
          subject

          posts = assigns(:posts)
          expect(posts.pluck(:id)).to eq [post_en.id]
        end
      end
    end
  end

  describe 'GET #show' do
    let!(:post) { create(:post) }

    let(:params) { {id: post.id} }

    subject { get :show, params: params}

    context 'when success' do
      it 'should render show template' do
        subject

        expect(response).to render_template(:show)
      end
    end

    context 'when fail' do
      context 'when the post do not exist' do
        let(:params) { {id: 0} }

        it 'should raise not found error' do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it 'should assigns empty post' do
      subject

      post = assigns(:post)
      expect(post).not_to eq nil
      expect(post.id).to eq nil
    end

    it 'should render new template' do
      subject

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:params) do
      {
        post: {
          subject: 'Test subject',
          subject_en: 'Test subject en',
          content: 'Content test subject',
          content_en: 'Content test subject en',
          status: :draft,
          categories: '',
          type: 'TechnicalPost'
        }
      }
    end

    subject { post :create, params: params }

    context 'when success' do
      it 'should add 1 post record to database' do
        expect { subject }.to change(Post, :count).by(1)
      end

      it 'should render notice flash message' do
        subject

        expect(flash[:notice]).to eq 'Post created'
      end

      context 'when has categories' do
        it 'should create categories record' do
          params[:post][:categories] = 'category;super category'

          expect { subject }.to change(Category, :count).by(2)
        end
      end
    end

    context 'when fail' do
      context 'when missing required field' do
        it 'should return can not blank error' do
          params[:post][:subject] = nil

          subject

          post = assigns(:post)
          expect(post.errors.messages[:subject]).to eq ["can't be blank"]
        end

        it 'should render alert flash message' do
          params[:post][:subject] = nil

          subject

          expect(flash[:alert]).to eq 'Post create failed'
        end
      end

      context 'when have one field exceed character limit' do
        it 'should return exceed limit character error' do
          params[:post][:subject] = 'a'*256

          subject

          post = assigns(:post)
          expect(post.errors.messages[:subject]).to eq ["is too long (maximum is 255 characters)"]
        end
      end
    end
  end

  describe 'GET #edit' do
    let(:post) { create(:post) }
    let(:params) { {id: post.id} }

    subject { get :edit, params: params }

    context 'when success' do
      it 'should render edit template' do
        subject

        expect(response).to render_template(:edit)
      end
    end

    context 'when post id not exist' do
      let(:params) { {id: 0} }

      it 'should raise not found error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PATCH #update' do
    let(:post) { create(:post) }
    let(:params) do
      {
        id: post.id,
        post: {
          subject: 'Test subject updated',
          subject_en: 'Test subject en',
          content: 'Content test subject',
          content_en: 'Content test subject en',
          status: :draft,
          categories: '',
          type: 'TechnicalPost'
        }
      }
    end

    subject { patch :update, params: params }

    context 'when success' do
      context 'when valid params without categories' do
        it 'should update post' do
          subject

          post = assigns(:post)
          expect(post.subject).to eq 'Test subject updated'
        end

        it 'should render update success flash message' do
          subject

          expect(flash[:notice]).to eq 'Post updated'
        end
      end

      context 'when valid params with categories' do
        it 'should create new categories' do
          params[:post][:categories] = 'category;super category'

          expect { subject }.to change(Category, :count).by(2)
        end
      end
    end

    context 'when fail' do
      context 'when post not exist' do
        it 'should raise not found error' do
          params[:id] = 0

          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when required field is empty' do
        it 'should return can not blank error' do
          params[:post][:subject] = ' '

          subject

          post = assigns(:post)
          expect(post.errors.messages[:subject]).to eq ["can't be blank"]
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post) }
    let(:params) { {id: post.id} }
    subject { delete(:destroy, params: params) }

    context 'when success' do
      it 'should destroy post' do
        expect { subject }.to change(Post, :count).by(-1)
      end

      it 'should redirect to admin post path' do
        subject

        expect(response).to redirect_to(admin_posts_path)
      end
    end

    context 'when fail' do
      before do
        allow_any_instance_of(Post).to receive(:destroy).and_return(false)
      end

      it 'should render alert flash message' do
        subject

        expect(flash.now[:alert]).to eq 'Post destroy failed'
      end

      it 'should render index' do
        expect(subject).to render_template(:index)
      end
    end
  end
end
