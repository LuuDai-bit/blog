class User < ApplicationRecord
  USER_WHITELIST_ATTRIBUTES = %i[name email].freeze

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
