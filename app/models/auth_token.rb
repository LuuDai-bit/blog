class AuthToken < ApplicationRecord
  validates :token, presence: true

  def mask
    self.token = '**********'
  end
end