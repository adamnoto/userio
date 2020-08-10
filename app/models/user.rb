class User < ApplicationRecord
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP,
    message: "must be a valid email address"
  validate :validate_password_decryptable, if: :password_hash_changed?

  before_save :normalize_email, if: :email_changed?

  def valid_password? passed_password
    password == "#{passed_password}#{salt}"
  end

  def password= val
    @raw_password = val

    write_attribute :salt, SecureRandom.uuid if salt.blank?

    if password_hash.blank? || password != @raw_password
      write_attribute :password_hash, BCrypt::Password.create(val + salt)
    end
  end

  def password
    return unless password_hash

    @password ||= BCrypt::Password.new(password_hash)
  end

  private

    def normalize_email
      # note: ensuring adamnoto@hey.com and ADAMNOTO@hey.com are of the same account
      write_attribute :email, email.downcase
    end

    def validate_password_decryptable
      unless password == "#{@raw_password}#{salt}"
        errors.add :password_hash, "undecryptable"
      end
    end

end
