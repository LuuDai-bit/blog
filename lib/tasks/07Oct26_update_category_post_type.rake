# frozen_string_literal: true

namespace :update_category_post_type do
  desc 'Update post category for idle post category'

  task migrate: :environment do
    p 'Begin'

    ActiveRecord::Base.transaction do
      idle_talk_category_ids = []
      IdleTalk.find_in_batches do |group|
        category_ids = group.map do |it|
          it.post_categories.pluck(:category_id)
        end.flatten
        category_ids = category_ids.flatten.uniq
        idle_talk_category_ids += category_ids
      end

      idle_talk_categories = Category.where(id: idle_talk_category_ids).includes(:posts)
      idle_talk_category_ids.each do |category_id|
        category = idle_talk_categories.detect { |itc| itc.id == category_id }

        is_technical_post_category = category.posts.any? { |p| p.type == 'TechnicalPost' }
        if is_technical_post_category
          dup_category = category.dup
          category = dup_category
        end

        category.update!(post_type: 'IdleTalk')
      end
    end

    p 'Updated'
  end
end
