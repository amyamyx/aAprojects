class Band < ApplicationRecord
  validates :name, presence: true

  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums, source: :tracks
  has_many :tags, as: :taggable, dependent: :destroy
end
