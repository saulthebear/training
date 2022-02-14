# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string           not null
#
class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  # validates :password_digest, presence: true
  validates :password_digest, presence: { message: 'can\'t be blank' }

  def self.find_by_credentials(username, password)
    user = find_by(username: username)

    return user if user&.is_password?(password)

    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(potential_password)
    password = BCrypt::Password.new(password_digest)
    password.is_password?(potential_password)
  end
end
