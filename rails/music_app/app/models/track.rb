class Track < ApplicationRecord
  validates :title, :ord, presence: true
  validates :title, uniqueness: { scope: :album_id }
  validates :bonus, inclusion: { in: [true, false] }

  belongs_to :album
  has_one :band, through: :album, source: :band
end
