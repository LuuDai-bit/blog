class Post < ApplicationRecord
  has_rich_text :content
  has_rich_text :content_en
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  belongs_to :author, class_name: User.name,
                      primary_key: :id, foreign_key: :user_id, optional: true

  validates :subject, presence: true, length: { minimun: 1, maximum: 255 }
  validates :release_date, presence: true, if: Proc.new { |post| post.status_publish? }

  enum status: Settings.enum.post.status.to_h, _prefix: true

  scope :order_by_views, ->(direction) do
    order(views: direction) if direction
  end

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

  scope :by_subject, ->(search_text) do
    return if search_text.blank?

    sql = <<-SQL
      LOWER(posts.subject) LIKE :subject
      OR LOWER(posts.subject_en) LIKE :subject
    SQL

    where(sql, subject: "%#{search_text.downcase}%")
  end

  scope :count_post_by_time, ->(start_day, end_day) do
    return if start_day.blank? || end_day.blank?

    # TODO: fix this logic to use release_date instead of created_at
    where(created_at: start_day..end_day, status: :publish).count
  end

  scope :by_locale, ->() do
    where.not(subject_en: nil, subject_en: '') if I18n.locale == :en
  end

  scope :by_type, ->(type) do
    where(type: type) if type.present?
  end

  def english_version_available?
    subject_en.present?
  end

  def self.types
    %w(TechnicalPost IdleTalk)
  end
end
