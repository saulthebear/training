# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :not_duplicate_response?
  validate :not_author_response?
  
  belongs_to(
    :respondent,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id
  )
  
  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :answer_choice_id
  )
  
  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  private

  def not_duplicate_response?
    # errors[:respondent] << 'can only answer once' if respondent_already_answered?
    errors.add(:respondent, :invalid, message: 'can only respond once') if respondent_already_answered?
  end
  
  def poll_author
    question.poll.author
  end
  
  def respondent_is_poll_author?
    poll_author.id == self.user_id
  end
  
  def not_author_response?
    errors.add(:respondent, :invalid, message: "cannot be poll's author") if respondent_is_poll_author?
  end

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.where(user_id: self.user_id).exists?
  end
end
