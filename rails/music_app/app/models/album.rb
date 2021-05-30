class Album < ApplicationRecord
  validates :title, :year, presence: true
  validates :band_id, uniqueness: { scope: :title }
  validates :live, inclusion: {in: [true, false] }

  belongs_to :band
end
