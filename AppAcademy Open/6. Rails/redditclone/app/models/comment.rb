# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  content           :text             not null
#  author_id         :bigint           not null
#  post_id           :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :bigint
#
class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :post

  belongs_to :author,
             class_name: :User

  has_many :child_comments,
           class_name: :Comment,
           foreign_key: :parent_comment_id

  belongs_to :parent_comment,
             class_name: :Comment,
             foreign_key: :parent_comment_id,
             optional: true
end
