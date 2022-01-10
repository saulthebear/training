# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  author_id  :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Poll < ApplicationRecord
  validates :author_id, presence: true
  validates :title, presence: true
end
