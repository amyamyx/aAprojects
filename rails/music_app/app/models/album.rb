class Album < ApplicationRecord
  validates :title, :year, :live, presence: true
  validates :band_id, uniqueness: { scope: :title }
  validates :live, inclusion: [true, false]

  belongs_to :band
end
