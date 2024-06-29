class Category < ApplicationRecord
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name,
            presence: true,
            length: { minimun: 1, maximum: 50 },
            uniqueness: true
end
