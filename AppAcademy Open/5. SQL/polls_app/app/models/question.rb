# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  validates :poll_id, presence: true
  validates :text, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    primary_key: :id,
    foreign_key: :poll_id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :question_id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    answer_choices_with_responses = answer_choices
                                    .select('answer_choices.*, COUNT(responses.id) AS response_count')
                                    .left_outer_joins(:responses)
                                    .group('answer_choices.id')

    results_hash = {}
    answer_choices_with_responses.each do |ac|
      results_hash[ac.text] = ac.response_count
    end
    results_hash
  end
end
