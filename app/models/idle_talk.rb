class IdleTalk < Post
  has_many :post_categories, foreign_key: :post_id
end
