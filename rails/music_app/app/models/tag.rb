class Tag < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: [:taggable_id, :taggalbe_type] }

  belongs_to :taggable, polymorphic: true
end