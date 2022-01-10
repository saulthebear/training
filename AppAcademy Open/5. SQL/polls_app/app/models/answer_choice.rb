# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  question_id :integer          not null
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class AnswerChoice < ApplicationRecord
  validates :question_id, presence: true
end
