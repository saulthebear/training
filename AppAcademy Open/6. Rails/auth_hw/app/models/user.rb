# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  attr_reader :password
  
  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return unless user
    
    password_digest = BCrypt::Password.new(user.password_digest)
    return user if password_digest.is_password?(password)
    
    return nil
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
