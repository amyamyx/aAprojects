require "bcrypt"

class User < ApplicationRecord
  validates :email, :session_token, :activation_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :activated, inclusion: { in: [true, false] }
  before_validation :ensure_session_token, :ensure_activation_token
  attr_reader :password

  has_many :notes, dependent: :destroy

  def self.generate_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def reset_token!
    self.session_token = User.generate_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_token
  end

  def ensure_activation_token
    self.activation_token ||= User.generate_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def activate!
    self.activated = true
    self.save!
  end
end
