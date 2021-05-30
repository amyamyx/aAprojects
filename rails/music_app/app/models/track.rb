class Track < ApplicationRecord
  validates :title, :ord, presence: true
  validates :ord, uniqueness: { scope: :album_id }
  validates :bonus, inclusion: { in: [true, false] }

  belongs_to :album
  has_one :band, through: :album, source: :band
  has_many :notes, dependent: :destroy
end
