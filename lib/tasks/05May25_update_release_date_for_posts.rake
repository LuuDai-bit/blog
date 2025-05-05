# frozen_string_literal: true

namespace :update_release_date_for_posts do
  desc 'Update release date for publish posts'

  task migrate: :environment do
    p 'Begin update release date'
    Post.status_publish.where(release_date: nil).find_in_batches do |group|
      posts_update_attributes = []
      group.each do |post|
        post.release_date = post.created_at
        posts_update_attributes << post.attributes
      end

      Post.upsert_all(posts_update_attributes)
    end
    p 'Updated release date successfully'
  end
end
