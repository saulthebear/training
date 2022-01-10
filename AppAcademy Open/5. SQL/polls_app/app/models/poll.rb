# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  author_id  :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Poll < ApplicationRecord
end
