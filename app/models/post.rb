class Post < ApplicationRecord
  validates :subject, :content, presence: true
end
