class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable
  USER_WHITELIST_ATTRIBUTES = %i[name email password password_confirmation].freeze

  has_many :user_reminders, dependent: :destroy
  has_many :reminders, through: :user_reminders

  validates :name, :email, :phone_number, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: Devise.email_regexp
end
