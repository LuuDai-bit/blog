class Post < ApplicationRecord
  has_rich_text :content

  belongs_to :author, class_name: User.name,
                      primary_key: :id, foreign_key: :user_id, optional: true

  validates :subject, presence: true

  enum status: Settings.enum.post.status.to_h, _prefix: true

  scope :order_by_status, ->() do
    sql = <<-SQL.squish
      CASE status
        WHEN 'draft' THEN 1
        WHEN 'publish' THEN 2
      END ASC,
      created_at DESC
    SQL

    order(Arel.sql(sql))
  end
end
