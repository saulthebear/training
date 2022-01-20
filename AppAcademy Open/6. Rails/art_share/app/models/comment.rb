# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  author_id  :string           not null
#  artwork_id :string           not null
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  validates :author_id, presence: true
  validates :artwork_id, presence: true
  validates :body, presence: true

  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id

  belongs_to :artwork,
    dependent: :destroy
end
