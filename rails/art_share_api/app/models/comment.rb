# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  artwork_id :integer          not null
#  user_id    :integer          not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"
    
  belongs_to :artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: "Artwork"

  has_many :likes,
    primary_key: :id,
    foreign_key: :likable_id,
    class_name: "Like",
    as: :likable
  
  has_many :likers,
    through: :likes,
    source: :liker
end
