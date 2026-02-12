require 'rails_helper'

RSpec.describe User::TechnicalPostsController, type: :controller do
  describe 'GET #index' do
    let(:params) { {locale: :vi} }

    subject { get :index, params: params }

    context 'without search and filter' do
      let!(:posts) { create_list(:post, 5, status: :publish, release_date: Time.current) }
      let!(:post) { create(:post, status: :draft) }

      it 'should return all publish post' do
        subject

        posts = assigns(:posts)
        expect(posts.to_a.pluck(:id).sort).to eq posts.pluck(:id).sort
      end

      it 'should render index template' do
        subject

        expect(response).to render_template(:index)
      end
    end

    context 'when search by post subject' do
      let!(:posts) do
        create_list(:post, 5, status: :publish, release_date: Time.current)
      end
      let!(:post_search_subject) do
        create(:post, subject: 'Search subject', status: :publish, release_date: Time.current)
      end

      let(:params) { {search_text: 'Search subject', locale: :vi} }

      it 'should return correct post with search subject' do
        subject

        posts = assigns(:posts)
        expect(posts.to_a.pluck(:id)).to eq [post_search_subject.id]
      end
    end

    context 'when filter by subject_en' do
      let!(:posts) do
        create_list(:post, 5, status: :publish, release_date: Time.current)
      end
      let!(:post_search_subject) do
        create(:post, subject_en: 'Search subject', status: :publish, release_date: Time.current)
      end
      let(:params) do
        {
          search_text: 'Search subject', locale: :en
        }
      end

      it 'should return correct post with search subject_en' do
        subject

        posts = assigns(:posts)
        expect(posts.to_a.pluck(:id)).to eq [post_search_subject.id]
      end
    end

    context 'when filter by category' do
      let(:category) { create(:category) }
      let!(:posts) { create_list(:post, 5, status: :publish, release_date: Time.current) }
      let(:post) { create(:post, status: :publish, release_date: Time.current) }

      let(:params) do
        {
          category_name: category.name,
          locale: :vi
        }
      end

      before do
        PostCategory.create!(post_id: post.id, category_id: category.id)
      end

      it 'should return correct post with matched category' do
        subject

        posts = assigns(:posts)
        expect(posts.to_a.pluck(:id)).to eq [post.id]
      end
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post, status: :publish, release_date: Time.current) }
    let(:params) { {id: post.id, locale: :vi} }

    subject { get :show, params: params }

    context 'when success' do
      it 'should render show template' do
        subject

        expect(response).to render_template(:show)
      end
    end

    context 'when post is draft' do
      let(:post) { create(:post, status: :draft) }

      it 'should return not found error' do
        subject

        expect(response.status).to eq 404
      end
    end
  end
end
