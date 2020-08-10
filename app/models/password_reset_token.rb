class PasswordResetToken < ApplicationRecord
  validates :token, uniqueness: true

  belongs_to :user

  before_create :generate_token

  def active?
    (created_at + 6.hours) >= Time.current
  end

  def to_param
    token
  end

  private

    def generate_token
      self.token = SecureRandom.alphanumeric
    end

end
