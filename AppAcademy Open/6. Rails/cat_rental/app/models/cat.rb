# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  CAT_COLORS = %w[White Black Ginger Grey Cream Brown].freeze
  validates :birth_date, presence: true
  validates :color, presence: true,
            inclusion: { in: CAT_COLORS, message: "%{value} is not a valid color."}
  validates :name, presence: true
  validates :sex, presence: true, inclusion: { in: %w[M F] }
  validates :description, presence: true
  
  has_many :rental_requests,
           class_name: 'CatRentalRequest',
           dependent: :destroy
  
  def age
    time_ago_in_words(birth_date)
  end
end
