class Collection < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id,
    message: "should only appear once per user"}

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :artwork_collections,
    primary_key: :id,
    foreign_key: :collection_id,
    class_name: "ArtworkCollection",
    dependent: :destroy
  
  has_many :collected_artworks,
    through: :artwork_collections,
    source: :artwork
end
