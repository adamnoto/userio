class User < ApplicationRecord
  attr_accessor :confirmation_password

  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP,
    message: "must be a valid email address"
  validate :validate_password_decryptable, if: :password_hash_changed?
  validate :validate_password_length, if: :password_hash_changed?
  validate :validate_password_matches_with_confirmation, if: :new_record?
  validates :username, length: { minimum: 5 }, unless: :new_record?

  before_save :normalize_email, if: :email_changed?
  before_create :assign_username_from_email

  has_many :password_reset_tokens

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

    BCrypt::Password.new(password_hash)
  end

  private

    def normalize_email
      # note: ensuring adamnoto@hey.com and ADAMNOTO@hey.com are of the same account
      write_attribute :email, email.downcase
    end

    def validate_password_decryptable
      unless valid_password? @raw_password
        errors.add :password_hash, "undecryptable"
      end
    end

    def validate_password_length
      return if @raw_password.length >= 8

      errors.add :password, "too short, must be at least 8-characters long"
    end

    def validate_password_matches_with_confirmation
      return if @raw_password == confirmation_password

      errors.add :confirmation_password, "does not match with the password"
    end

    def assign_username_from_email
      write_attribute :username, email.split("@").first
    end

end
