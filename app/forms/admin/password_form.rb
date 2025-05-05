class Admin::PasswordForm
  include ActiveModel::Model

  attr_accessor :password, :password_confirmation, :id

  validates :password, :password_confirmation, :id, presence: true
  validates :password, length: { minimum: 8, maximum: 32 }
  validates :password, format: { with: Settings.models.user.password }
  validate :password_confirmation_match

  def save
    if valid?
      user = User.find(id)
      user.update!(password: password)
      true
    else
      false
    end
  end

  private

  def password_confirmation_match
    return if password_confirmation == password

    errors.add(:password_confirmation, 'does not match')
  end
end
