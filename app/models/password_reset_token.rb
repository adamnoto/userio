class PasswordResetToken < ApplicationRecord
  belongs_to :user

  before_create :generate_token

  def active?
    (created_at + 6.hours) >= Time.current
  end

  private

    def generate_token
      self.token = SecureRandom.alphanumeric
    end

end
