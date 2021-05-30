class Band < ApplicationRecord
  validates :name, presence: true

  has_many :albums, dependent: :true
end
