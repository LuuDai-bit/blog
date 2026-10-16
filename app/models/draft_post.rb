class DraftPost < ApplicationRecord
  has_rich_text :content
  has_rich_text :content_en

  belongs_to :post
end
