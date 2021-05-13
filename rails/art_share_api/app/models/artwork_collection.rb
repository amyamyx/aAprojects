class ArtworkCollection < ApplicationRecord
  validates :collection_id, uniqueness: { scope: :artwork_id }

  belongs_to :artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: "Artwork"

  belongs_to :collection,
    primary_key: :id,
    foreign_key: :collection_id,
    class_name: "Collection"
end
