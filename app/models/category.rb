class Category < ApplicationRecord
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name,
            presence: true,
            length: { minimun: 1, maximum: 50 },
            uniqueness: true

  scope :by_name, ->(search_name) {
    return unless search_name.present?

    where(name: search_name)
  }
end
