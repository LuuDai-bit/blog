class DraftPost < ApplicationRecord
  has_rich_text :content
  has_rich_text :content_en

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
end
