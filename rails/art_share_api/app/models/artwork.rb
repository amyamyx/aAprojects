# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  img_url    :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
  validates :title, :img_url, presence: true
  validates :title, uniqueness: { scope: :artist_id,
    message: "should not have duplicate title for the same artist" }

  belongs_to :artist,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: "User"

  has_many :artwork_shares,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: "ArtworkShare",
    dependent: :destroy
  
  has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer

  has_many :comments,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: "Comment",
    dependent: :destroy
  
  has_many :likes,
    primary_key: :id,
    foreign_key: :likable_id,
    class_name: "Like",
    as: :likable

  has_many :likers,
    through: :likes,
    source: :liker
end
