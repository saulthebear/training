# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint           not null, primary key
#  post_id    :bigint           not null
#  sub_id     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PostSub < ApplicationRecord
  validates :sub, uniqueness: { scope: [:post] }

  belongs_to :sub

  belongs_to :post
end
