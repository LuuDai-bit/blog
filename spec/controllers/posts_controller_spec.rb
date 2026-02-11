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
  end
end
