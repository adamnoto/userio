class User < ApplicationRecord
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP,
    message: "must be a valid email address"

  before_save :normalize_email, if: :email_changed?

  private

    def normalize_email
      # note: ensuring adamnoto@hey.com and ADAMNOTO@hey.com are of the same account
      write_attribute :email, email.downcase
    end

end
