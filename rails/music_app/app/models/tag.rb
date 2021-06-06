class Tag < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: [:taggable_id, :taggable_type] }

  belongs_to :taggable, polymorphic: true

  def self.search(name, model = nil)
    tags = Tag.where("name LIKE ?", "%#{ name }%").includes(:taggable)
    tags = tags.select { |tag| tag.taggable_type == model } if model && model != ""
    tags.map { |tag| tag.taggable }
  end
end