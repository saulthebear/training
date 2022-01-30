class Track < ApplicationRecord
  validates :title, :ord, presence: true
  
  belongs_to :album
  
  has_one :band, through: :album
  
  def track_type
    is_bonus ? 'Bonus Track' : 'Regular Track'
  end
end
