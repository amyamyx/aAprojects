# == Schema Information
#
# Table name: likes
#
#  id           :bigint           not null, primary key
#  likable_type :string
#  likable_id   :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  liker_id     :integer          not null
#
class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  
  belongs_to :liker,
    primary_key: :id,
    foreign_key: :liker_id,
    class_name: "User"
end
