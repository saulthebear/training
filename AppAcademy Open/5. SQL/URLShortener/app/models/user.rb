# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls, class_name: :ShortenedUrl, foreign_key: :submitter_id
  has_many :visits, class_name: :Visit
  has_many :visited_urls,
    -> { distinct },
    through: :visits,
    source: :url
end
