class Category < ApplicationRecord
  validates :name,
            presence: true,
            length: { minimun: 1, maximum: 50 },
            uniqueness: true
end
