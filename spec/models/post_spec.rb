# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build(:post) }

  subject { post }

  describe 'associations' do
    it { should have_many(:post_categories) }
    it { should have_many(:categories) }
    it { should belong_to(:author).class_name(User.name)
                                  .with_foreign_key(:user_id)
                                  .optional }
  end

  describe 'validates' do
    it { should validate_presence_of(:subject) }

    context 'when post status is public' do
      let(:technical_post) { build(:post, status: :publish) }

      subject { technical_post }

      it { should validate_presence_of(:release_date) }
    end
  end

  describe 'scopes' do
    context '.order_by_views' do
      let!(:post_10_views) { create(:post, views: 10) }
      let!(:post_0_views) { create(:post, views: 0) }
      let!(:post_5_views) { create(:post, views: 5) }

      let(:direction) { 'asc' }

      subject { Post.order_by_views(direction) }

      context 'when sort by asc' do
        it 'should sort Post by views' do
          posts = subject

          expect(posts.pluck(:id)).to eq [post_0_views.id,
                                          post_5_views.id,
                                          post_10_views.id]
        end
      end

      context 'when sort by desc' do
        let(:direction) { 'desc' }

        it 'should sort post by view desc' do
          posts = subject

          expect(posts.pluck(:id)).to eq [post_10_views.id,
                                          post_5_views.id,
                                          post_0_views.id]
        end
      end
    end

    context '.order_by_status' do
      let!(:post_status_publish) { create(:post, status: :publish, release_date: Time.current) }
      let!(:post_status_draft) { create(:post, status: :draft) }
      let!(:post_status_publish2) { create(:post, status: :publish, release_date: Time.current) }

      subject { Post.order_by_status }

      it 'should put draft post to the top' do
        posts = subject

        expect(posts.pluck(:id).first).to eq post_status_draft.id
      end
    end

    context '.by_subject' do
      let!(:post) { create(:post, subject: 'Test search') }
      let!(:post2) { create(:post, subject: 'Some thoughts') }

      let(:keyword) { 'Test search' }

      subject { Post.by_subject(keyword) }

      it 'should return array of matched posts' do
        posts = subject

        expect(posts.pluck(:id)).to eq [post.id]
      end
    end

    context '.count_post_by_time' do
      let!(:post) do
        create(:post,
               created_at: Time.current.ago(5.days),
               status: :publish,
               release_date: Time.current)
      end
      let!(:post2) { create(:post, status: :publish, release_date: Time.current) }
      let!(:post3) { create(:post, created_at: Time.current.ago(5.days)) }

      subject { Post.count_post_by_time(Time.current.ago(6.days), Time.current.ago(1.day)) }

      it 'should return 1' do
        post_count = subject

        expect(post_count).to eq 1
      end
    end

    context '.by_locale' do
      let!(:post_without_en) { create(:post) }
      let!(:post_with_empty_en) { create(:post, subject_en: '') }
      let!(:post_with_en_subject) { create(:post, subject_en: 'Test subject') }

      subject { Post.by_locale }

      before { I18n.locale = locale }

      context 'when locale is :en' do
        let(:locale) { :en }

        it 'should return posts that has subject_en' do
          posts = subject

          expect(posts.pluck(:id)).to eq [post_with_en_subject.id]
        end
      end

      context 'when locale is :vi' do
        let(:locale) { :vi }

        it 'should return all posts' do
          posts = subject

          expect(posts.length).to eq 3
        end
      end
    end

    context '.by_type' do
      let!(:technical_post) { create(:post, type: 'TechnicalPost') }
      let!(:idle_talk) { create(:post, type: 'IdleTalk') }

      subject { Post.by_type(filter_type) }

      context 'when filter by technical post' do
        let(:filter_type) { 'TechnicalPost' }

        it 'should return 1 techinical post' do
          posts = subject

          expect(posts.pluck(:id)).to eq [technical_post.id]
        end
      end

      context 'when filter by idle talk' do
        let(:filter_type) { 'IdleTalk' }

        it 'should return 1 idle talk' do
          posts = subject

          expect(posts.pluck(:id)).to eq [idle_talk.id]
        end
      end

      context 'when filter is nil' do
        let(:filter_type) { nil }

        it 'should return all posts' do
          posts = subject

          expect(posts.length).to eq 2
        end
      end
    end
  end

  describe 'instance functions' do
    context '.english_version_available?' do
      let(:post_with_subject_en) { create(:post, subject_en: 'Test') }
      let(:post_without_subject_en) { create(:post) }

      context 'when post has subject en' do
        it 'should return true' do
          expect(post_with_subject_en.english_version_available?).to eq true
        end
      end

      context 'when post does not has subject en' do
        it 'should return false' do
          expect(post_without_subject_en.english_version_available?).to eq false
        end
      end
    end
  end

  describe 'class functions' do
    context '#types' do
      it 'should return all available type' do
        expect(Post.types).to eq %w[TechnicalPost IdleTalk]
      end
    end
  end
end
