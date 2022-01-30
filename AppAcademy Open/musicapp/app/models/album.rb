class Album < ApplicationRecord
  validates :title, :year, presence: true
  
  belongs_to :band
  
  has_many :tracks, dependent: :destroy
  
  def album_type
    self.is_live? ? 'Live Album' : 'Studio Album'
  end
  
  def band_name
    self.band.name
  end
end
