class Category < ApplicationRecord
  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  validates :name,
            presence: true,
            length: { minimun: 1, maximum: 50 },
            uniqueness: true
  validates :highlight_order, numericality: { greater_than: 0, less_than_or_equal_to: 5 }, allow_nil: true
  validate :maximum_highlighted_categories

  scope :by_name, ->(search_name) {
    return unless search_name.present?

    where(name: search_name)
  }

  scope :highlighted_ordered, -> { where(highlighted: true).order(:highlight_order) }

  scope :higher_eq_order, -> (highlight_order) { where('highlight_order >= ?', highlight_order) }

  scope :lower_order, -> (highlight_order) do
    return if highlight_order.blank?

    where('highlight_order < ?', highlight_order)
  end

  scope :highlighted_and_id_ordered, -> do
    sql = <<-SQL.squish
      CASE highlighted
        WHEN true THEN 1
        WHEN false THEN 2
      END ASC,
      categories.highlight_order ASC,
      categories.id DESC
    SQL

    order(Arel.sql(sql))
  end

  before_save :adjust_highlight_order

  private

  def maximum_highlighted_categories
    if highlighted? && highlighted_changed?
      if Category.where(highlighted: true).count >= 5
        errors.add(:highlighted, "can't highlight more than 5 categories")
      end
    end
  end

  def adjust_highlight_order
    return unless highlighted? && highlight_order.present?

    if highlight_order_changed? || highlighted_changed?
      Category.where(highlighted: true)
              .higher_eq_order(highlight_order)
              .lower_order(highlight_order_was)
              .where.not(id: id)
              .update_all('highlight_order = highlight_order + 1')
    end
  end
end
