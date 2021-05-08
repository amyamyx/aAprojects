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
  validates :artwork_id, uniqueness: {
    scope: :viewer_id,
    messgae: "Can't be shared again to the same viewer."
  }
  validates :favorite, inclusion: { in: [true, false] }

  belongs_to :viewer,
    primary_key: :id,
    foreign_key: :viewer_id,
    class_name: "User"

  belongs_to :shared_artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: "Artwork"
end
