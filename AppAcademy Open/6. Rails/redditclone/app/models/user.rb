# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string           not null
#  session_token   :string           not null
#
class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  # validates :password_digest, presence: true
  validates :password_digest, presence: { message: 'can\'t be blank' }

  after_initialize :ensure_session_token

  has_many :subs,
           foreign_key: :moderator_i

  has_many :posts,
           foreign_key: :author_id

  has_many :comments,
           foreign_key: :author_id,
           dependent: :destroy

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = find_by(username: username)

    return user if user&.is_password?(password)

    nil
  end

  def self.find_by_session_token(token)
    find_by(session_token: token)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(potential_password)
    password = BCrypt::Password.new(password_digest)
    password.is_password?(potential_password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    save!
    session_token
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
