# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  validates :title, presence: true
  validates :subs, presence: true

  has_many :post_subs,
           dependent: :destroy

  has_many :subs,
           through: :post_subs

  has_many :comments,
           dependent: :destroy

  belongs_to :author,
             class_name: :User,
             foreign_key: :author_id

  def comments_by_parent_id
    hash = Hash.new { |h, k| h[k] = [] }

    comments.each do |comment|
      hash[comment.parent_comment_id].append(comment)
    end

    hash
  end
end
