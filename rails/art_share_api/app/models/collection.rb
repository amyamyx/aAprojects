class Collection < ApplicationRecord
  validates :user_id, uniqueness: { scope: :artwork_id,
  message: "can only collect the same artwork once" }

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  belongs_to :artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: "Artwork"
end
