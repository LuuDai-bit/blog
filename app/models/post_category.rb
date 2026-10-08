class PostCategory < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :category
end
