# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :artist_id,
    message: "should be unique per artist" }
  validates :image_url, presence: true
  validates :artist_id, presence: true
  
  belongs_to :artist,
    class_name: "User",
    primary_key: :id,
    foreign_key: :artist_id
  
  has_many :artwork_shares

  has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer

  has_many :comments,
    dependent: :destroy

  has_many :likes,
    as: :likeable
end
