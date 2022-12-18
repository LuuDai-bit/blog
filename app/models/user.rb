class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable
  USER_WHITELIST_ATTRIBUTES = %i[name email password password_confirmation].freeze

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
