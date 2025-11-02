class Admin::PostForm
  include ActiveModel::Model

  # validate :max_number_of_categories

  attr_accessor :id, :subject, :subject_en, :content, :content_en, :categories,
                :status, :user_id, :type

  validates :subject, presence: true, length: { minimun: 1, maximum: 255 }

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def categories=(attributes)
    @categories = []
    category_names = attributes.split(';')
    exist_categories = Category.where(name: category_names)

    category_names.each do |name|
      category = exist_categories.detect { |c| c.name == name }
      if category.blank?
        category = Category.new(name: name)
        if !category.valid?
          errors.add(:categories, category.errors.full_messages.first)
        end
      end

      @categories << category
    end
  end

  private

  def max_number_of_categories
  end

  def persist!
    if id.present?
      post = Post.find(id)
      post.assign_attributes(post_attributes)
    else
      post = Post.new(post_attributes)
    end
    post.categories = categories unless categories.nil?
    update_release_date(post)
    post.save!
  end

  def post_attributes
    {
      id: id,
      subject: subject,
      subject_en: subject_en,
      content: content,
      content_en: content_en,
      status: status,
      user_id: user_id,
      type: type
    }
  end

  def update_release_date(post)
    return unless post.status_publish? && post.release_date.blank?

    post.release_date = Time.current
  end

  def attach_categories_to_post
    category_names = params[:categories]&.pluck(:name)
    return unless category_names.present?

    exist_categories = Category.where(name: category_names)
    post_categories = []
    params[:categories].each do |category_param|
      category = exist_categories.detect { |c| c.name == category_param[:name] }
      if category.blank?
        category = Category.new(category_param)
        if !category.valid?
          errors.add(:categories, category.errors.full_messages.first)
          return
        end
      end

      post_categories << category
    end

    @post.categories = post_categories
  end
end
