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
  
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: { message: "Password can't be blank" }
  
  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = self.find_by(username: username)
    return user if user&.is_password?(password)

    nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    return self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    parsed_password_digest = BCrypt::Password.new(self.password_digest)
    parsed_password_digest.is_password?(password)
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
