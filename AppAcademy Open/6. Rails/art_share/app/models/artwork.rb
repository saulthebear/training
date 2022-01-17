class Artwork < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :artist_id,
    message: "should be unique per artist" }
  validates :image_url, presence: true
  validates :artist_id, presence: true
  
  belongs_to :artist,
    class_name: "User",
    primary_key: :id,
    foreign_key: :artist_id
end
