# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "action_view"

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: %w(yellow black white flower grey), 
    message: "can only be a set of accepted colors" }
  validates :sex, inclusion: { in: [ "M", "F"], 
    messeage: "can only be M or F" }

  has_many :cat_rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "CatRentalRequest",
    dependent: :destroy

  belongs_to :owner, 
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  def age
    distance_of_time_in_words_to_now(self.birth_date) + " old"
  end
end


