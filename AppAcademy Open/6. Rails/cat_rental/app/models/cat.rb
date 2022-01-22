class Cat < ApplicationRecord
  COLORS = %w[White Black Ginger Grey Cream Brown].freeze
  validates :birth_date, presence: true
  validates :color, presence: true,
    inclusion: { in: COLORS, message: "%{value} is not a valid color."}
  validates :name, presence: true
  validates :sex, presence: true, inclusion: { in: %w[M F] }
  validates :description, presence: true
  
  def self.COLORS
    COLORS
  end
end
