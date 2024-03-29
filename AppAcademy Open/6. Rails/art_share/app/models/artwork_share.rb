# == Schema Information
#
# Table name: artwork_shares
#
#  id         :bigint           not null, primary key
#  artwork_id :integer          not null
#  viewer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ArtworkShare < ApplicationRecord
  validates :artwork_id, presence: true, uniqueness: {
    scope: :viewer_id,
    message: "should be unique per viewer"
  }
  validates :viewer_id, presence: true
  
  belongs_to :artwork
    
  belongs_to :viewer,
    class_name: "User",
    foreign_key: :viewer_id
end
